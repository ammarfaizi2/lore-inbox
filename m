Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbVIRQ4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbVIRQ4P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 12:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbVIRQ4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 12:56:15 -0400
Received: from ns.firmix.at ([62.141.48.66]:35205 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1751233AbVIRQ4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 12:56:15 -0400
Subject: Re: [Patch] Support UTF-8 scripts
From: Bernd Petrovitsch <bernd@firmix.at>
To: 7eggert@gmx.de
Cc: "Martin v." =?ISO-8859-1?Q?L=F6wis?= <martin@v.loewis.de>,
       "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <E1EGnQr-00047F-HK@be1.lrz>
References: <4Nvab-7o5-11@gated-at.bofh.it> <4Nvab-7o5-13@gated-at.bofh.it>
	 <4Nvab-7o5-15@gated-at.bofh.it> <4Nvab-7o5-17@gated-at.bofh.it>
	 <4Nvab-7o5-19@gated-at.bofh.it> <4Nvab-7o5-21@gated-at.bofh.it>
	 <4Nvab-7o5-23@gated-at.bofh.it> <4Nvab-7o5-25@gated-at.bofh.it>
	 <4Nvab-7o5-27@gated-at.bofh.it> <4NvjM-7CU-7@gated-at.bofh.it>
	 <4NvjM-7CU-5@gated-at.bofh.it> <4NxbR-20S-1@gated-at.bofh.it>
	 <4NEn7-3M5-7@gated-at.bofh.it> <4NTvO-yJ-13@gated-at.bofh.it>
	 <E1EGnQr-00047F-HK@be1.lrz>
Content-Type: text/plain
Organization: http://www.firmix.at/
Date: Sun, 18 Sep 2005 18:53:39 +0200
Message-Id: <1127062419.8395.28.camel@gimli.at.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-09-18 at 02:53 +0200, Bodo Eggert wrote:
> Bernd Petrovitsch <bernd@firmix.at> wrote:
[...]
> > Most of the text editors have ways to markup the source files. Not even
> > the various editors are able to agreen on one method for all, so why
> > could the (Linux) world agree on one for all text files?
> 
> You don't need a marker for all text files, but it's legal to have a marker
> for utf-8 text files (see the uniocode standard 4.0.0 section 15.9), and
> it's handy to use it until you made everybody in the world convert
> everything to utf-8 (but not utf-{16,32}{le,be}).

Have fun patching almost every text processing tool and concept out
there.
Apart from that the way of that marker is wrong it seems to me that the
UTF-8 body has no other choice than such a insane "rule" or
recommendation).

> >> > With this marker you are interferign with (at least) *all* text files.
> >> 
> >> Hmm. What does that have to do with the patch I'm proposing? This
> >> patch does *not* interfere with all text files. It is only relevant
> >> for executable files starting with the #! magic.
> > 
> > It *does* interfere since scripts are also text files in every aspect.
> > So every feature you want for "scripts" you also get for text files (and
> > vice versa BTW).
> 
> If utf-8 encoded text files are text files, and text files are scripts,

No one said all text files are scripts, instead it is the other way
'round.

[ snipped because of ex falso quod libet ]

> > If you think "script" and "text file" are different, define both of
> > them, please, otherwise a discussion is pointless.
> 
> If all text files are script files, execute this mail.

See above. Obviously you misunderstand some thing.

> >> > And there are always tools out there which simply do not understand the
> >> > generic marker and can not ignore it since these bytes are part of the
> >> > file.
> >> 
> >> This conclusion is false. Many tools that don't understand the file
> >> structure still can do their job on the files. So the fact that a tool
> >> does not understand the structure does not necessarily imply that
> >> the tool breaks when the structure changes.
> > 
> > It *may* break just because of some to-be-ignored inline marking due to
> > some questionable feature.
> 
> How exactly does it break, and what is it? And why must *it* be prevented
> from breaking by ignoring script signatures in valid text files?

The question was: What is if this marker in encountered within a file?
To be ignored (by UTF-8 aware tools)? Some other interpretation?
Illegal/Forbidden?

> > And *when* (not if) it breaks, it is probably cumbersome to find since
> > you have pretty unprintable characters.
> 
> If your tools can't print utf-8 encoded characters, they are broken for
> ISO-8859-*, too. Besides that, it's not a kernel problem.

Which is again not true since lots of tools out there printed ISO-8859-*
correctly before UTF-8 was deployed.

[...]

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbVIQWar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbVIQWar (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 18:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbVIQWar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 18:30:47 -0400
Received: from ns.firmix.at ([62.141.48.66]:46980 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1751151AbVIQWaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 18:30:46 -0400
Subject: Re: [Patch] Support UTF-8 scripts
From: Bernd Petrovitsch <bernd@firmix.at>
To: "\"Martin v." =?ISO-8859-1?Q?L=F6wis=22?= <martin@v.loewis.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <432BB59C.8060108@v.loewis.de>
References: <4NsP0-3YF-11@gated-at.bofh.it> <4NsP0-3YF-13@gated-at.bofh.it>
	 <4NsP0-3YF-15@gated-at.bofh.it> <4NsP0-3YF-17@gated-at.bofh.it>
	 <4NsP1-3YF-19@gated-at.bofh.it> <4NsP1-3YF-21@gated-at.bofh.it>
	 <4NsOZ-3YF-9@gated-at.bofh.it> <4NsYH-4bv-27@gated-at.bofh.it>
	 <4NtBr-4WU-3@gated-at.bofh.it> <4Nu4p-5Js-3@gated-at.bofh.it>
	 <432B2E09.9010407@v.loewis.de> <1126910730.3520.7.camel@gimli.at.home>
	 <432BB59C.8060108@v.loewis.de>
Content-Type: text/plain; charset=UTF-8
Organization: http://www.firmix.at/
Date: Sun, 18 Sep 2005 00:28:13 +0200
Message-Id: <1126996093.3373.21.camel@gimli.at.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-09-17 at 08:20 +0200, "Martin v. Löwis" wrote:
> Bernd Petrovitsch wrote:
> > On Fri, 2005-09-16 at 22:41 +0200, "Martin v. Löwis" wrote:
> > [ Language-specific examples ]
> > 
> > And that's the only working way - the programming languages can actually
> > do it because it defines the syntax and semantics of the contents
> > anyways.
> 
> It works from the programming language point of view, but it is a mess
> from the text editor point of view.

Most of the text editors have ways to markup the source files. Not even
the various editors are able to agreen on one method for all, so why
could the (Linux) world agree on one for all text files?

> Even for the programming language, it is a pain to implement: what
> if you have non-ASCII characters before the pragma that declares the
> encoding? and so on.

That's the problem of the language definers who absolutely want such
(IMHO absolutely superflous) features.

> > With this marker you are interferign with (at least) *all* text files.
> 
> Hmm. What does that have to do with the patch I'm proposing? This
> patch does *not* interfere with all text files. It is only relevant
> for executable files starting with the #! magic.

It *does* interfere since scripts are also text files in every aspect.
So every feature you want for "scripts" you also get for text files (and
vice versa BTW).
If you think "script" and "text file" are different, define both of
them, please, otherwise a discussion is pointless.

> > And there are always tools out there which simply do not understand the
> > generic marker and can not ignore it since these bytes are part of the
> > file.
> 
> This conclusion is false. Many tools that don't understand the file
> structure still can do their job on the files. So the fact that a tool
> does not understand the structure does not necessarily imply that
> the tool breaks when the structure changes.

It *may* break just because of some to-be-ignored inline marking due to
some questionable feature.
And *when* (not if) it breaks, it is probably cumbersome to find since
you have pretty unprintable characters.
Let alone the confusion why the size of a file with `ls -l` is different
from the size in the editor or a marker-aware `wc -c`.
So IMHO either you have a clear and visible marker or you none at all.

> > Or another example: (Try to) start a perl/shell/... script (without
> > paranmeter on the first line) which was edited on Win* and binary copied
> > to a Unix system. Or at least guess what will happen ....
> 
> For a Python script, I don't need to guess: It will just work.

Then write a short python script (with a "#!/usr/bin/python" line at the
start [without parameters]) natively on a Win*-system, copy it binary
over to an arbitrary Linux system and see what's happening.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services




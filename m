Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbVIPWsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbVIPWsF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 18:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbVIPWsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 18:48:05 -0400
Received: from ns.firmix.at ([62.141.48.66]:35203 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1750742AbVIPWsE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 18:48:04 -0400
Subject: Re: [Patch] Support UTF-8 scripts
From: Bernd Petrovitsch <bernd@firmix.at>
To: "\"Martin v." =?ISO-8859-1?Q?L=F6wis=22?= <martin@v.loewis.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <432B2E09.9010407@v.loewis.de>
References: <4NsP0-3YF-11@gated-at.bofh.it> <4NsP0-3YF-13@gated-at.bofh.it>
	 <4NsP0-3YF-15@gated-at.bofh.it> <4NsP0-3YF-17@gated-at.bofh.it>
	 <4NsP1-3YF-19@gated-at.bofh.it> <4NsP1-3YF-21@gated-at.bofh.it>
	 <4NsOZ-3YF-9@gated-at.bofh.it> <4NsYH-4bv-27@gated-at.bofh.it>
	 <4NtBr-4WU-3@gated-at.bofh.it> <4Nu4p-5Js-3@gated-at.bofh.it>
	 <432B2E09.9010407@v.loewis.de>
Content-Type: text/plain; charset=UTF-8
Organization: http://www.firmix.at/
Date: Sat, 17 Sep 2005 00:45:29 +0200
Message-Id: <1126910730.3520.7.camel@gimli.at.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-16 at 22:41 +0200, "Martin v. Löwis" wrote:
[ Language-specific examples ]

And that's the only working way - the programming languages can actually
do it because it defines the syntax and semantics of the contents
anyways.
With this marker you are interferign with (at least) *all* text files.
And thus with *all* tools which "handle" those text files.

> So you *must* use encoding declarations in some languages; the UTF-8

... if you absolutely want to use Non-ASCII characters in the source
code. In most (if not all) of them exist a native gettext()
interface ...

> signature is a particularly convenient way of doing so, since it allows
> for uniformity across languages, with no need for the text editors to
> parse all the different programming languages.

And there are always tools out there which simply do not understand the
generic marker and can not ignore it since these bytes are part of the
file. And thus tools (and people) will kill those markers (for whatever
reason and if it's simple ignorance) anyway.

Or another example: (Try to) start a perl/shell/... script (without
paranmeter on the first line) which was edited on Win* and binary copied
to a Unix system. Or at least guess what will happen ....

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services




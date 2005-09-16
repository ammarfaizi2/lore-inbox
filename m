Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbVIPUlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbVIPUlt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 16:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbVIPUlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 16:41:49 -0400
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:6784 "EHLO
	smtprelay03.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751274AbVIPUls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 16:41:48 -0400
Message-ID: <432B2E09.9010407@v.loewis.de>
Date: Fri, 16 Sep 2005 22:41:45 +0200
From: =?ISO-8859-1?Q?=22Martin_v=2E_L=F6wis=22?= <martin@v.loewis.de>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
References: <4NsP0-3YF-11@gated-at.bofh.it> <4NsP0-3YF-13@gated-at.bofh.it> <4NsP0-3YF-15@gated-at.bofh.it> <4NsP0-3YF-17@gated-at.bofh.it> <4NsP1-3YF-19@gated-at.bofh.it> <4NsP1-3YF-21@gated-at.bofh.it> <4NsOZ-3YF-9@gated-at.bofh.it> <4NsYH-4bv-27@gated-at.bofh.it> <4NtBr-4WU-3@gated-at.bofh.it> <4Nu4p-5Js-3@gated-at.bofh.it>
In-Reply-To: <4Nu4p-5Js-3@gated-at.bofh.it>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> You don't have markers (although they're defined, see ISO 2022) for your
> 8-bit encodings, and *THEY'RE THE ONES THAT NEED TO BE DISTINGUISHED.*
> Flagging UTF-8, especially with the BOM (as opposed to the ISO 2022
> signature, <ESC>%G) is pointless in the context, since you still can't
> distinguish your arbitrary number of legacy encodings.

In programming languages that support the notion of source encodings,
you do have markers for 8-bit encodings. For example, in Python, you
can specify

# -*- coding: iso-8859-1 -*-

to denote the source encoding. In Perl, you write

use encoding "latin-1";

(with 'use utf8;' being a special-case shortcut).

In Java, you can specify the encoding through the -encoding argument
to javac. In gcc, you use -finput-charset (with the special case of
-fexec-charset and -fwide-exec-charset potentially being different).

So you *must* use encoding declarations in some languages; the UTF-8
signature is a particularly convenient way of doing so, since it allows
for uniformity across languages, with no need for the text editors to
parse all the different programming languages.

Regards,
Martin

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030451AbWCTVux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030451AbWCTVux (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 16:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbWCTVux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 16:50:53 -0500
Received: from hera.kernel.org ([140.211.167.34]:21151 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S964993AbWCTVuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 16:50:52 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: VFAT: Can't create file named 'aux.h'?
Date: Mon, 20 Mar 2006 13:50:29 -0800 (PST)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <dvn835$lvo$1@terminus.zytor.com>
References: <1142890822.5007.18.camel@localhost.localdomain> <20060320134533.febb0155.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1142891429 22521 127.0.0.1 (20 Mar 2006 21:50:29 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 20 Mar 2006 21:50:29 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20060320134533.febb0155.rdunlap@xenotime.net>
By author:    "Randy.Dunlap" <rdunlap@xenotime.net>
In newsgroup: linux.dev.kernel
> 
> "AUX" is (was) a reserved "filename" in DOS.  The Linux MS-DOS
> filesystem preserves (protects) that.  The extension part does not
> matter; it only checks the first 8 characters of the filename.
> You'll need to use a different filesystem or filename...
> 

But this is VFAT, not FAT.  It should probably take the reserved name
and mangle it.

> 
> /* MS-DOS "device special files" */
> static const unsigned char *reserved_names[] = {
> 	"CON     ", "PRN     ", "NUL     ", "AUX     ",
> 	"LPT1    ", "LPT2    ", "LPT3    ", "LPT4    ",
> 	"COM1    ", "COM2    ", "COM3    ", "COM4    ",
> 	NULL
> };
> 

There should be more than that.  At the very least there is "CLOCK$"
(arguably anything with $), "MSCD001" (and probably more than 001), as
well as "COM5".."COM8".

	-hpa

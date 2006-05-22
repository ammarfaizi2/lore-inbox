Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbWEVS65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbWEVS65 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 14:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbWEVS65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 14:58:57 -0400
Received: from hera.kernel.org ([140.211.167.34]:38344 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751066AbWEVS65 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 14:58:57 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Linux Kernel Source Compression
Date: Mon, 22 May 2006 11:58:50 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e4t1la$u3p$1@terminus.zytor.com>
References: <Pine.LNX.4.64.0605211028100.4037@p34> <200605212003.32063.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1148324330 30842 127.0.0.1 (22 May 2006 18:58:50 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 22 May 2006 18:58:50 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200605212003.32063.s0348365@sms.ed.ac.uk>
By author:    Alistair John Strachan <s0348365@sms.ed.ac.uk>
In newsgroup: linux.dev.kernel
> 
> Somebody needs to make lzma userspace tools (like p7zip) faster, not crash, 
> and behave like a regular UNIX program. Then we need a patch to GNU tar to 
> emerge, and for it to persist for at least 4 years. Then maybe people will 
> adopt this format..
> 

The patch to GNU tar isn't necessary.  If the "not crash, and behave
like a regular UNIX program" can be satisfied, I'd be happy to support
7zip/lzma on kernel.org.  Unfortunately, as far as I can tell:

a) right now the standard encapsulation format for LZMA is 7zip, which
only comes in the form of hideously ugly code.  lzma-tools are
cleaner, but incompatible.

b) Even lzma-tools relies on a shell script to behave like a Unix
program.

Personally, I would like to suggest adding LZMA capability to gzip.
The gzip format already has support for multiple compression formats.

	-hpa

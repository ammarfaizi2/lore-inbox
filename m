Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266775AbUBMG0Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 01:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266780AbUBMG0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 01:26:23 -0500
Received: from hera.kernel.org ([63.209.29.2]:50581 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S266775AbUBMG0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 01:26:22 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [BUG] get_unmapped_area() change -> non booting machine
Date: Fri, 13 Feb 2004 06:26:10 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c0hqm2$g1n$1@terminus.zytor.com>
References: <1076384799.893.5.camel@gaston> <20040213002358.1dd5c93a.ak@suse.de> <20040212100446.GA2862@elte.hu> <Pine.LNX.4.58.0402120833000.5816@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Trace: terminus.zytor.com 1076653570 16440 63.209.29.3 (13 Feb 2004 06:26:10 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 13 Feb 2004 06:26:10 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.58.0402120833000.5816@home.osdl.org>
By author:    Linus Torvalds <torvalds@osdl.org>
In newsgroup: linux.dev.kernel
> 
> I really think that we should aim for "brk()" just working. It's often
> faster than mmap, and it's one of those very basic things (ie we should
> _not_ assume we have glibc and malloc(), and others may well want to use
> brk() too).
> 

Okay... I'll ask... what is the point with brk(), i.e. what makes it
faster?  If we didn't have brk(), we could get rid of UNMAPPED_BASE
and therefore get rid of the artificial splitting of userspace memory
(modulo prelink, but that's optional.)

brk() at least on the surface really looks like a strange legacy
interface.  Obviously it's important on nommu architectures, but on
mmu architectures it seems rather redundant.

	-hpa
-- 
PGP public key available - finger hpa@zytor.com
Key fingerprint: 2047/2A960705 BA 03 D3 2C 14 A8 A8 BD  1E DF FE 69 EE 35 BD 74
"The earth is but one country, and mankind its citizens."  --  Bahá'u'lláh
Just Say No to Morden * The Shadows were defeated -- Babylon 5 is renewed!!

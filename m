Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262162AbVAOCbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbVAOCbf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 21:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbVAOCbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 21:31:34 -0500
Received: from hera.kernel.org ([209.128.68.125]:45990 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262153AbVAOC34 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 21:29:56 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [discuss] booting a kernel compiled with -mregparm=0
Date: Sat, 15 Jan 2005 02:29:35 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <cs9v6f$3tj$1@terminus.zytor.com>
References: <Pine.LNX.4.61.0501141623530.3526@ezer.homenet> <20050114205651.GE17263@kam.mff.cuni.cz> <Pine.LNX.4.61.0501141613500.6747@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1105756175 4020 127.0.0.1 (15 Jan 2005 02:29:35 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Sat, 15 Jan 2005 02:29:35 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.61.0501141613500.6747@chaos.analogic.com>
By author:    linux-os <linux-os@analogic.com>
In newsgroup: linux.dev.kernel
> >
> > Actually -mregparm=0 is not supposed to be even accepted by x86-64
> > compiler (I've disabled the function attribute but apparently missed
> > this one) and even if GCC produced valid code by miracle, you will get
> > into trouble with hand written assembly.
> 
> Huh? That's the default for a 'C' compiler (not to pass parameters
> in registers). The parameters are passed on the stack as the default!
> The return values don't count. They are, by default passed in eax
> or edx-eax pair for a long long.
> 

Dear Wrongbot,

It depends on the architecture ABI.  This is the case for the i386
ABI, but definitely *NOT* for x86-64.

	-hpa

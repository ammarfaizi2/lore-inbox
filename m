Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754051AbWKGGAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754051AbWKGGAE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 01:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754054AbWKGGAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 01:00:04 -0500
Received: from nz-out-0102.google.com ([64.233.162.192]:42651 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1754051AbWKGGAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 01:00:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TfJ1+4Su3g1Mw7NvZJ+mWk12wDjegf6fd9IIlWdWsYFaJOM3XLNRanmG1BCzGwsMtjExtwfVMmnlpo8oE6ps4WuL50QsxWP3KnJeO3BPOZC90CLJezBmTsTtGUeznFQh3Zfy8HLK5yrXjihmwUAXbAMdBLv1D9xNR8G4O/jd8YE=
Message-ID: <f55850a70611062200x764bf09fkbbaeb61e66138c91@mail.gmail.com>
Date: Tue, 7 Nov 2006 14:00:00 +0800
From: "Zhao Xiaoming" <xiaoming.nj@gmail.com>
To: linux-kernel@vger.kernel.org, "Linux Netdev List" <netdev@vger.kernel.org>
Subject: Re: ZONE_NORMAL memory exhausted by 4000 TCP sockets
In-Reply-To: <f55850a70611061850i47ca73adt6a5c71e6732db69e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <f55850a70611052207j384e1d3flaf40bb9dd74df7c5@mail.gmail.com>
	 <454EE580.5040506@cosmosbay.com> <454F6483.4010307@osdl.org>
	 <f55850a70611061850i47ca73adt6a5c71e6732db69e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest update:
    It seems that Linux kernel memory management mechanisms including
buddy and slab algorisms are not very efficient under my test
conditions that tcp stack requires a lot of (hundreds of MB) packet
buffers and release them very frequently.
    Here is the proof. After change my kernel configuration to support
2/2 VM splition, LOMEM consumption reduced to 270M bytes compared with
640M bytes of the 1/3 kernel. All test conditions are the same and
memory pages allocated by TCP stack are also the same, 34K ~ 38K
pages. In other words, 'lost' memory changed from ~500M to ~130M.
Thus, I have nothing to do but guessing the much more free pages make
the slab/buddy algorisms more efficient and waste less memory.
    Finally I got what I want. Thank you all for your help and advices.

Xiaoming.

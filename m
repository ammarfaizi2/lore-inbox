Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277581AbRJHWp0>; Mon, 8 Oct 2001 18:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277586AbRJHWpP>; Mon, 8 Oct 2001 18:45:15 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19475 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277581AbRJHWo4>; Mon, 8 Oct 2001 18:44:56 -0400
Subject: Re: [PATCH] change name of rep_nop
To: dwmw2@infradead.org (David Woodhouse)
Date: Mon, 8 Oct 2001 23:49:41 +0100 (BST)
Cc: frival@zk3.dec.com (Peter Rival), paulus@samba.org,
        Martin.Bligh@us.ibm.com (Martin J. Bligh),
        alan@lxorguk.ukuu.org.uk (Alan Cox), torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, jay.estabrook@compaq.com,
        rth@twiddle.net
In-Reply-To: <13962.1002580586@redhat.com> from "David Woodhouse" at Oct 08, 2001 11:36:26 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qjDR-0002AQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> While we're on the subject of stupidly named routines and x86-isms, I'm 
> having trouble reconciling this text in Documentation/cachetlb.txt:
> 
> 	1) void flush_cache_all(void)
> 
> 	        The most severe flush of all.  After this interface runs,
> 	        the entire cpu cache is flushed.

I suspect the real definition should be

	"After this interface runs the device and other views of 
	 memory includes all dirty cache lines on the processor. On 
	 processors with cache coherent bus interfaces this may well
	 be a no operation

	 Footnote: AGP tends to have its own coherency and caching setup
	 so the AGP drivers use their own interfaces to avoid needless
	 overhead"


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266765AbTBCQMp>; Mon, 3 Feb 2003 11:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266792AbTBCQMo>; Mon, 3 Feb 2003 11:12:44 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:41873
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266765AbTBCQMo>; Mon, 3 Feb 2003 11:12:44 -0500
Subject: Re: [BUG] vmalloc, kmalloc - 2.4.x
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1044286828.2397.26.camel@gregs>
References: <1044284924.2402.12.camel@gregs>
	 <1044289102.21009.1.camel@irongate.swansea.linux.org.uk>
	 <1044286828.2397.26.camel@gregs>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044292722.21009.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 03 Feb 2003 17:18:42 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-03 at 15:40, Grzegorz Jaskiewicz wrote:
> On Mon, 2003-02-03 at 16:18, Alan Cox wrote:
> 
> > Firstly vmalloc isnt permitted in interrupt context (use kmalloc with GFP_KERNEL),
> > although for such small chunks you might want to vmalloc a bigger buffer once
> > at startup.
> i've allso tried kmalloc with the same result.
> Also, in this example it is timer - module isn't cleanly wroted becouse
> it supose to be only an example.

If I build the example using the cleanups I suggested it works for me. The FPU one btw
seems to be a red herring, my gcc is outputting a precomputed integer constant

Alan


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269409AbUJSNwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269409AbUJSNwa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 09:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269410AbUJSNwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 09:52:30 -0400
Received: from mail4.worldserver.net ([217.13.200.24]:64155 "EHLO
	mail4.worldserver.net") by vger.kernel.org with ESMTP
	id S269409AbUJSNwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 09:52:22 -0400
Date: Tue, 19 Oct 2004 15:52:14 +0200
From: Christian Leber <christian@leber.de>
To: linux-kernel@vger.kernel.org
Subject: Re: DMA memory allocation --how to  more than 1 MB
Message-ID: <20041019135214.GA29435@core.home>
References: <4EE0CBA31942E547B99B3D4BFAB34811175F32@mail.esn.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB34811175F32@mail.esn.co.in>
X-Accept-Language: de en
X-Location: Europe, Germany, Mannheim
X-Operating-System: Debian GNU/Linux (sid)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2004 at 11:18:13AM +0530, Srinivas G. wrote:
> I have a doubt about allocating the DMA memory using kmalloc OR
> __get_dma_pages OR pci_alloc_consistent. I was unable to allocate the
> memory greater than 1 MB using any one of the above memory functions. 
> 
> Is there any other method which will allocate the DMA memory greater
> than 1 MB?

You should be able to get at least order 9, therefore 2 MB.
With kernel 2.6 you should also be able to get order 10, therefore 4 MB.
If you need more you have to puzzle the areas together.

The way wli suggested is better.
But if this is no possible just make it a requierement to load the
module while booting, then there are enough free areas.


Christian Leber

-- 
  "Omnis enim res, quae dando non deficit, dum habetur et non datur,
   nondum habetur, quomodo habenda est."       (Aurelius Augustinus)
  Translation: <http://gnuhh.org/work/fsf-europe/augustinus.html>

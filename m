Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264321AbTDPMBj (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 08:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264323AbTDPMBj 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 08:01:39 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:38338
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264321AbTDPMBi (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 16 Apr 2003 08:01:38 -0400
Subject: Re: PixelView video4linux driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alexandru Damian <ddalex_krn@easynet.ro>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E9D150E.6000601@easynet.ro>
References: <Pine.LNX.4.53.0303211420170.13876@chaos>
	 <1048324118.3306.3.camel@LNX.iNES.RO> <3E7F1B6A.2000103@easynet.ro>
	 <1048525157.25655.1.camel@irongate.swansea.linux.org.uk>
	 <3E7F321A.1000809@easynet.ro> <87ptog628m.fsf@bytesex.org>
	 <3E9C196F.5060205@easynet.ro>  <3E9D150E.6000601@easynet.ro>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050491720.28727.28.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Apr 2003 12:15:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-04-16 at 09:32, Alexandru Damian wrote:
> Maybe someone can help me with a hint about what's going on, and how should
> I handle interlocking between X and clgdtv.

If you don't need things like DMA buffers you could put the code
entirely in the Xv support for that hardware and not touch the
kernel. If you need the kernel then it gets rather hairier. DRI 
keeps fast locks between the DRI clients and the X server.



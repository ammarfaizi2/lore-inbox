Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWEWObs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWEWObs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 10:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWEWObs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 10:31:48 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:455 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932100AbWEWObr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 10:31:47 -0400
Subject: Re: OpenGL-based framebuffer concepts
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Jeff Garzik <jeff@garzik.org>, Manu Abraham <abraham.manu@gmail.com>,
       linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <83B4C39B-1A5E-4734-A5FF-10C3179B535B@mac.com>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <44700ACC.8070207@gmail.com> <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com>
	 <1148379089.25255.9.camel@localhost.localdomain>
	 <4472E3D8.9030403@garzik.org>
	 <83B4C39B-1A5E-4734-A5FF-10C3179B535B@mac.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 23 May 2006 15:43:53 +0100
Message-Id: <1148395433.25255.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-05-23 at 10:10 -0400, Kyle Moffett wrote:
> A GPU which does not support OpenGL at all would look virtually  

No GPU today "supports" OpenGL

> 2)  Client program sends OpenGL commands through kernel framebuffer  
> device.
> 3)  Kernel either passes the OpenGL commands to the GPU or if they  
> were trapped by the software renderer it passes them to that, which  
> can emulate them using more primitive operations.

You've no idea how a GPU works have you ?

The process generally goes something like this.

I build an OpenGL rendering context.
The supporting library JITs an engine which implements this rendering
context and pipeline. Only a JIT is really fast enough because there are
so many tests are otherwise involved.

Each poly is fired down the JIT engine which produces a mix of
	- AGP command streams
	- GPU bytecodes
	- Polygon breakdowns which go back into the engine
		(eg for clips the chip can't do)
	- Texture loads and swaps

The GPU view of the universe is far far from the OpenGL one. With the
possible exception of the big 3D Labs cards anyway.

Alan


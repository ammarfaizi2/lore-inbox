Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbWEWQlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWEWQlg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 12:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWEWQlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 12:41:36 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16352 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750863AbWEWQlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 12:41:35 -0400
Subject: Re: OpenGL-based framebuffer concepts
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Jeff Garzik <jeff@garzik.org>, Manu Abraham <abraham.manu@gmail.com>,
       linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <ADF9B4F7-2B6E-41B7-8B83-26261EBE27F7@mac.com>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <44700ACC.8070207@gmail.com> <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com>
	 <1148379089.25255.9.camel@localhost.localdomain>
	 <4472E3D8.9030403@garzik.org>
	 <83B4C39B-1A5E-4734-A5FF-10C3179B535B@mac.com>
	 <1148395433.25255.66.camel@localhost.localdomain>
	 <ADF9B4F7-2B6E-41B7-8B83-26261EBE27F7@mac.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 23 May 2006 17:53:46 +0100
Message-Id: <1148403226.25255.89.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-05-23 at 11:41 -0400, Kyle Moffett wrote:
> So a modern GPU is essentially a proprietary CPU with an obscure  
> instruction set and lots of specialized texel hardware?  Given the  
> total lack of documentation from either ATI or NVidia about such  
> cards I'd guess it's impossible for Linux to provide any kind of  
> reasonable 3d engine for that kind of environment, and it might be  
> better to target a design like the Open Graphics Project is working  
> to provide.

Its typically a device you feed a series of fairly low level rendering
commands to sometimes including instructions (eg shaders). DRI provides
an interface that is chip dependant but typically looks like


      [User provided command buffer]
                    |
      [Kernel filtering/DMA interface]
                    |
      [Card command queue processing]


All the higher level graphic work is done in the 3D client itself.


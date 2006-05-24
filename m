Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbWEXAKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbWEXAKj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 20:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbWEXAKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 20:10:38 -0400
Received: from smtpout.mac.com ([17.250.248.172]:64507 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932489AbWEXAKi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 20:10:38 -0400
In-Reply-To: <9e4733910605231017g146e16dfnd61eb22a72bd3f5f@mail.gmail.com>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <44700ACC.8070207@gmail.com> <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com> <200605230048.14708.dhazelton@enter.net> <9e4733910605231017g146e16dfnd61eb22a72bd3f5f@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6896241F-3389-4B20-9E42-3CCDDBFDD312@mac.com>
Cc: "D. Hazelton" <dhazelton@enter.net>, Manu Abraham <abraham.manu@gmail.com>,
       linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: OpenGL-based framebuffer concepts
Date: Tue, 23 May 2006 20:10:01 -0400
To: Jon Smirl <jonsmirl@gmail.com>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 23, 2006, at 13:17:18, Jon Smirl wrote:
>> By implementing a framework where userspace doesn't have to know -  
>> or care - about the hardware, which, IMNSHO, is the way things  
>> should be, then userspace applications can take advantage of such  
>> a system and be even more stable.
>
> A true monolithic design doesn't really work for video hardware. In  
> the monolithic model all devices in a class present a uniform API.  
> The better design for GPUs is the exo-kernel model. DRM already  
> uses the exo-kernel model. With exokernels each driver presents a  
> unique API and userspace libraries are used to provide a uniform API.

The one really significant potential problem with the exo-kernel  
model for graphics is that the kernel *must* have a stable way to  
display kernel panics regardless of current video mode, framebuffer  
settings, 3D rendering, etc.  The kernel driver should be able to  
provide some fundamental operations for compositing text on top of  
the framebuffer at the primary viewport regardless of whatever  
changes userspace makes to the GPU configuration.  We don't have this  
now, but I see it as an absolute requirement for any replacement  
graphics system.  This means that the kernel driver should be able to  
understand and modify the entire GPU state to the extent necessary  
for such a text console.

Cheers,
Kyle Moffett


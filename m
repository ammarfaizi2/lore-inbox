Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270879AbUJVEgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270879AbUJVEgQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 00:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270857AbUJUTeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 15:34:15 -0400
Received: from mail.scitechsoft.com ([63.195.13.67]:65005 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S270845AbUJUTaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 15:30:12 -0400
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 21 Oct 2004 12:30:01 -0700
MIME-Version: 1.0
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <4177ABC9.22263.20E9CAFD@localhost>
In-reply-to: <1098313825.12374.74.camel@localhost.localdomain>
References: <4176E08B.2050706@techsource.com>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> I've actually always wondered what a hybrid video device would
> look like for 3D. Doing the alpha blend and very basic operations
> only in the hardware that are expensive in software - alpha and
> perhaps some of the texture scaling, but walking textures in
> software, doing shaders in software and so on. 

Well that is what most of the early 3D cards started out as. A lot of the 
early SGI boxes that has '3D' were not full 3D rendering engines but span 
based rendering engines. Not only was setup done in software, but so was 
the walking of the triangle sides and the only thing passed to the 
hardware was commands to render spans (flat, smooth or textured). You 
could build any kind of complex renderer on top of this and in those days 
it was SGI GL (pre OpenGL) that was the rendering API. The systems were 
also reasonably fast for the day too.

I think the original 3DLabs GLINT SX chipset also did span rendering and 
support textured spans. The biggest problem is that the overhead required 
by the CPU to process anything close to the volume of triangles per 
second that high end cards can handle today is overwhelming. Even a 4Ghz 
P4 probably couldn't keep up trying to match the transform, lighting and 
span traversal to match even a basic Radeon 9000 card IMHO. And then 
you've got no CPU cycles left for anything else such as sound and game 
physics ;-)

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270540AbUJUAei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270540AbUJUAei (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 20:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270513AbUJUAdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 20:33:49 -0400
Received: from smtp07.auna.com ([62.81.186.17]:42912 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id S270490AbUJUAam convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 20:30:42 -0400
Date: Thu, 21 Oct 2004 00:30:40 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
To: Timothy Miller <theosib@yahoo.com>
Cc: linux-kernel@vger.kernel.org
References: <20041020234819.23232.qmail@web40706.mail.yahoo.com>
In-Reply-To: <20041020234819.23232.qmail@web40706.mail.yahoo.com> (from
	theosib@yahoo.com on Thu Oct 21 01:48:19 2004)
X-Mailer: Balsa 2.2.5
Message-Id: <1098318640l.25188l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.10.21, Timothy Miller wrote:
...
> 
> When it comes to desktop applications, the FIRST thing you need is good
> 2D acceleration.  In fact, that's really the ONLY thing.  OpenOffice
> does not need to use OpenGL.  GNOME doesn't need to use OpenGL.  In
> fact, for the most part, they don't bother.  There are some instances
> where they use OpenGL, but most of what a workstation user does fits
> squarely within all the functionality supplied by Xlib, which is
> entirely 2D.
> 

Have you looked at xorg-x11 recently ? IE, the Composite, Damage and
Render extensions ?

OSX uses OpenGL because it is the API they have to access things like
alpha blending, image scaling, and so on, so they can do those nice
effects of transparencies, shadows, genie's and so on. At least until
Panther. For me, it looks like the new Tiger implementation (CoreImage) is
their own implementation of the OpenGL pixel pipeline, talking directly
to drivers instead of using OpenGL as intermediary.

Probably desktop systems would not need the T&L part of 3D, but be sure
they will need at least managing windows at different depths, blending them,
anti-aliasing them an so on.

So, as I see it, for an appealing 2D card, you need to program a 2 1/2
graphics engine, with really _fast_ alpha blending and antialiasing.
You can only kill the matrix part. I do not know if you will be able to
get rid completely of floating point, for those alpha mixes and assorted
candy...

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-rc4-mm1 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #4



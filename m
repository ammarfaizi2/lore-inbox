Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVC1JrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVC1JrG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 04:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVC1JrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 04:47:06 -0500
Received: from userf193.dsl.pipex.com ([62.188.53.193]:1465 "HELO
	mail.ezplanet.net") by vger.kernel.org with SMTP id S261416AbVC1JrB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 04:47:01 -0500
Subject: Re: imps2 mouse driver and bug 2082
From: Mauro Mozzarelli <mauro@ezplanet.net>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200503272321.49899.dtor_core@ameritech.net>
References: <1111966642.5789.7.camel@helios.ezplanet.org>
	 <200503272321.49899.dtor_core@ameritech.net>
Content-Type: text/plain
Organization: EzPlanet
Date: Mon, 28 Mar 2005 09:46:52 +0000
Message-Id: <1112003212.5698.9.camel@helios.ezplanet.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry,

I reckon that the reconnection should be automatic, with the kernel
driver being able to detect a sync loss. I understand that the patch you
originally posted might not be ideal, however I have been using it
successfully for months now (modified for 2.6.9 and 2.6.10) and I have
included it in the standard kernel distributed with EzPlanet One.

Although we may not want to include this patch as it is, I would
consider the prioritization of this issue to be resolved in future
kernel releases.

Mauro

On Sun, 2005-03-27 at 23:21 -0500, Dmitry Torokhov wrote:
> Hi,
> 
> On Sunday 27 March 2005 18:37, Mauro Mozzarelli wrote:
> > The mouse driver, re-developed for kernel 2.6, ever since the earliest
> > 2.6 release lost the ability to reset a broken link with an IMPS2 mouse
> > (this happens when disconnecting the mouse plug either physically or
> > through a "non imps2" KVM switch). The result is that the mouse can no
> > longer be controlled, with the only solution being a RE-BOOT!
> >
> 
> You can re-initialize mouse with the following command (while mouse is
> connected):
> 
>         echo -n "reconnect" > /sys/bus/serio/devices/serioX/drvctl
> 
> where serioX is serio port your mouse is connected to. You can find out
> which one by examining the driver link:
> 



 


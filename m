Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbULEF2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbULEF2b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 00:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbULEF2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 00:28:31 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:6061 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261251AbULEF20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 00:28:26 -0500
Message-Id: <200412050032.iB50Wkpo026066@laptop11.inf.utfsm.cl>
To: David Ford <david+challenge-response@blue-labs.org>
cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] misleading error message 
In-Reply-To: Message from David Ford <david+challenge-response@blue-labs.org> 
   of "Thu, 02 Dec 2004 07:33:41 CDT." <41AF0BA5.5080901@blue-labs.org> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Sat, 04 Dec 2004 21:32:46 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford <david+challenge-response@blue-labs.org> said:

[...]

> I want to be able to request information about a whooplesnoople without 
> it triggering a module load request, to determine if it's compiled in 
> statically.  I want to be able to distinguish static a static 
> whooplesnoople from a modularly loaded whooplesnoople.

The running kernel might have been compiled with whooplesnoople support,
but the module isn't there (or is broken); there are modules (think the
infamous binary drivers, but the NTFS and ipw-2x00 drivers are fully open
source examples I use) that can be loaded into "any" running kernel (even
build them after the kernel was built). A part of the module mechanism is
exactly for making that possible, so this is not a _kernel_ property, but a
_setup_ property.

The only reliable way of finding out if support is there is by using it. Or
groping inside /etc/modprobe.conf and /lib/modules &c to find out, if you
are brave. I'm chicken.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

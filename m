Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263740AbTDYUTM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 16:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263910AbTDYUTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 16:19:12 -0400
Received: from 015.atlasinternet.net ([212.9.93.15]:34788 "EHLO
	antoli.gallimedina.net") by vger.kernel.org with ESMTP
	id S263740AbTDYUTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 16:19:10 -0400
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: linux-kernel@vger.kernel.org
Subject: BUG: 2.5.68 "psmouse.c: Lost synchronization, throwing 2 bytes away"
Date: Fri, 25 Apr 2003 22:31:18 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304252231.18406.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

psmouse.c: Lost synchronization, throwing 2 bytes away.
psmouse.c: Lost synchronization, throwing 2 bytes away.
psmouse.c: Lost synchronization, throwing 2 bytes away.

This is the message produced by 2.5.68 (dmesg) if the mouse is moved fast 
enough (in may case a touchpad or the USB mouse) and in such a way the 
the (KDE) applicaction _seems_ to be forced to redraw the window.

The effect is that several KDE menus start to appear magically.

Some info:
- Kernel preempt is enabled.
- It has the same effect with/without dri.
- It occurs very often, always if you move the pointer from one side to 
the other of the screnn.
- It doesn't happen if the point doesn't go out from a window.
- Xfree 4.3/KDE 3.1.1
- X is not reniced.
- PIII speedstep (Latitude X200 - 933 MHz)

Hope this helps.


-- 
  ricardo galli       GPG id C8114D34

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263012AbTDFPXv (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 11:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263016AbTDFPXu (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 11:23:50 -0400
Received: from wall.ttu.ee ([193.40.254.238]:28678 "EHLO wall.ttu.ee")
	by vger.kernel.org with ESMTP id S263012AbTDFPXu (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 11:23:50 -0400
Date: Sun, 6 Apr 2003 18:34:57 +0300 (EET DST)
From: Siim Vahtre <siim@pld.ttu.ee>
To: linux-kernel@vger.kernel.org
cc: linux-fbdev-devel@lists.sourceforge.net
Subject: i810fb compile/module loading failure on 2.5.66-bk12
Message-ID: <Pine.GSO.4.53.0304061824230.17774@pitsa.pld.ttu.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When trying to load module i810 on 2.5.66-bk12 I get:
i810fb: Unknown symbol __memcpy

It also happens (in a bit different way) when I try to link it while
compiling directly into kernel.

I fixed it by changing
            memcpy_toio(d_addr, s_addr, s_pitch * image->height);
on drivers/video/i810/i810_accel.c:419 to:
            memcpy(d_addr, s_addr, s_pitch * image->height);

I have no idea what I've just done but... it works for me. :-)

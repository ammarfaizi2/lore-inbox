Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264338AbTDPMXc (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 08:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264340AbTDPMXb 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 08:23:31 -0400
Received: from wall.ttu.ee ([193.40.254.238]:29956 "EHLO wall.ttu.ee")
	by vger.kernel.org with ESMTP id S264338AbTDPMXb 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 08:23:31 -0400
Date: Wed, 16 Apr 2003 15:34:57 +0300 (EET DST)
From: Siim Vahtre <siim@pld.ttu.ee>
To: James Simmons <jsimmons@infradead.org>
cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: bug in i810_init_cursor
In-Reply-To: <Pine.LNX.4.44.0304152000360.8236-100000@phoenix.infradead.org>
Message-ID: <Pine.GSO.4.53.0304161530350.17774@pitsa.pld.ttu.ee>
References: <Pine.LNX.4.44.0304152000360.8236-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Apr 2003, James Simmons wrote:
>
> Try the latest BK pull. This should be fixed. Let me know.

Finally had the time to test. I tried 2.5.67-mm3 (which should have
framebuffer updates) and the bug was still there:

Linux version 2.5.67-mm3 (siim@void) (gcc version 3.2.3 20030407 (Debian prerelease)) #1 Mon Apr 14 19:53:14 EEST 2003
....
[dvd_do_auth+834/1392] dvd_do_auth+0x342/0x570
[<cc9fd4bb>] putcs_aligned+0x17b/0x1d0 [fbcon]
[<c896be55>] i810_init_cursor+0x25/0x50 [i810fb]
[<c896ccfc>] i810fb_cursor+0x5c/0x250 [i810fb]
[<cc9fd82f>] accel_putcs+0x8f/0xd0 [fbcon]
....

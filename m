Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263848AbTDIWod (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 18:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263857AbTDIWod (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 18:44:33 -0400
Received: from air-2.osdl.org ([65.172.181.6]:11904 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263848AbTDIWoc (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 18:44:32 -0400
Date: Wed, 9 Apr 2003 15:55:38 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-mm1 cause framebuffer crash at bootup
Message-Id: <20030409155538.5df5cc1f.rddunlap@osdl.org>
In-Reply-To: <1B46F2144C@vcnet.vc.cvut.cz>
References: <1B46F2144C@vcnet.vc.cvut.cz>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Apr 2003 23:52:51 +0200 "Petr Vandrovec" <VANDROVE@vc.cvut.cz> wrote:

| On  9 Apr 03 at 14:45, Randy.Dunlap wrote:
| >  [<c029367a>] fbcon_set_display+0x33a/0x4c0
| >  [<c01f8031>] set_inverse_transl+0x41/0xa0
| 
| Can you remove 'printk(KERN_DEBUG "%s: %ux%u, vt=%u, init=%u, ...'
| from fbcon_set_display (drivers/video/console/fbcon.c)? On my system
| printk(KERN_DEBUG) does not print nothing to the console even before
| syslogd is started (one wonders why...), but on your system it apparently
| triggers output to console before video mode was set.

Yes, I did that and can report that this one printk() kills it for me.
I.e., it boots and runs fine with this line commented out, but when I
put it back and rebuild, that kernel gets the same oops during boot.

--
~Randy

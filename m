Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263852AbTDIVlu (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 17:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263857AbTDIVlu (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 17:41:50 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:59627 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S263852AbTDIVlt (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 17:41:49 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Randy.Dunlap" <rddunlap@osdl.org>
Date: Wed, 9 Apr 2003 23:52:51 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.5.67-mm1 cause framebuffer crash at bootup
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <1B46F2144C@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  9 Apr 03 at 14:45, Randy.Dunlap wrote:
>  [<c029367a>] fbcon_set_display+0x33a/0x4c0
>  [<c01f8031>] set_inverse_transl+0x41/0xa0

Can you remove 'printk(KERN_DEBUG "%s: %ux%u, vt=%u, init=%u, ...'
from fbcon_set_display (drivers/video/console/fbcon.c)? On my system
printk(KERN_DEBUG) does not print nothing to the console even before
syslogd is started (one wonders why...), but on your system it apparently
triggers output to console before video mode was set.
                                            Thanks,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                


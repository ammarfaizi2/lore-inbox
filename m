Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263999AbTIIKTj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 06:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263997AbTIIKTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 06:19:39 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:15762 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S263999AbTIIKTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 06:19:38 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Zoup <Zoup@zoup.org>
Date: Tue, 9 Sep 2003 12:19:05 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Frame Buffer Problem . 
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <C89A06A7261@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  9 Sep 03 at 13:37, Zoup wrote:

> got blank screen when enable Frame Buffer console on 2.6.0-test5 :) 
> Config file attached . 

Do not enable vga16, vesafb and riva together. Decided for only one
of them, and use just that one. Although your configuration should give
you /dev/fb0 on riva, /dev/fb1 on vesafb and /dev/fb2 on vga16,
it looks like that you got reordered framebuffers somehow. Did not you
pass 'video=vga16fb:XXXX' option to the kernel? What kernel cmdline you 
used?

Other possibility is that vga16 setup confused your hardware enough for
picture to disappear... Doing 'cat /proc/fb > /non-working-fbs;
dmesg >> /non-working-fbs' after you boot your system with non-working
display could give us clue what's going on. But in any case, do not use
more than one fbdev...
                                                Petr Vandrovec
                                                


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263799AbUFFQkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263799AbUFFQkY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 12:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263807AbUFFQkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 12:40:24 -0400
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:640
	"HELO home.linuxace.com") by vger.kernel.org with SMTP
	id S263799AbUFFQkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 12:40:22 -0400
Date: Sun, 6 Jun 2004 09:40:21 -0700
From: Phil Oester <kernel@linuxace.com>
To: linux-kernel@vger.kernel.org
Subject: SysRq oddity with iptables logging
Message-ID: <20040606164021.GA1021@linuxace.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a heavily loaded gateway/firewall which performs quite a bit of logging (at
level DEBUG), I occasionally see iptables logs bleeding into SysRq data.
For example via serial:

telnet> send brk
m
SysRq : Show Memory
Mem-info:
DMA per-cpu:<7>EXT: IN=eth0 OUT=eth1 SRC=82.133.69.241 DST=10.2.242.181 LEN=98 TOS=0x00 PREC=0x00 TTL=20 ID=5087 PROTO=UDP SPT=60516 DPT=2967 LEN=78 

cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1

...

Note how the packet log just sandwiched itself in the middle of the data.

Is this expected behavior?

Phil Oester


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbTHZRTn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 13:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbTHZRTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 13:19:43 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:3819 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261651AbTHZRTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 13:19:41 -0400
From: Christian Hesse <news@earthworm.de>
To: Nigel Cunningham <ncunningham@clear.net.nz>,
       Willy Tarreau <willy@w.ods.org>
Subject: Re: 2.4.22 hangs with pcmcia and linux-wlan
Date: Tue, 26 Aug 2003 19:19:32 +0200
User-Agent: KMail/1.5.3
Cc: "Hmamouche, Youssef" <youssef@ece.utexas.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.21.0308252234010.25458-100000@linux08.ece.utexas.edu> <20030826041116.GI734@alpha.home.local> <1061871679.3327.11.camel@laptop-linux>
In-Reply-To: <1061871679.3327.11.camel@laptop-linux>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308261919.32488.news@earthworm.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 August 2003 06:21, Nigel Cunningham wrote:
> Bingo.

No luck for me.

root@kronos-one:~# cat /proc/interrupts
           CPU0
  0:      14024          XT-PIC  timer
  1:        381          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:          2          XT-PIC  i82365
  8:          1          XT-PIC  rtc
  9:          8          XT-PIC  acpi
 11:         16          XT-PIC  usb-uhci, usb-uhci
 14:       3317          XT-PIC  ide0
 15:          5          XT-PIC  ide1
NMI:          0
LOC:      13984
ERR:         10
MIS:          0

> Now I just need to learn how to get it to assign a different IRQ.

Add "exclude irq 9" to /etc/pcmcia/config.opts

Christian


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266758AbUJREbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266758AbUJREbF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 00:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266802AbUJREbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 00:31:05 -0400
Received: from mailgate1.sover.net ([209.198.87.60]:58583 "EHLO mx1.sover.net")
	by vger.kernel.org with ESMTP id S266758AbUJREbB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 00:31:01 -0400
Message-ID: <41734721.3070508@sover.net>
Date: Mon, 18 Oct 2004 00:31:29 -0400
From: Stephen Wille Padnos <spadnos@sover.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: I/O card vs linux
References: <200410160423.43597.gene.heskett@verizon.net>
In-Reply-To: <200410160423.43597.gene.heskett@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:

>Greetings;
>
>This may be OT, but can anyone advise me on a pci card thats basicly 
>an 8255 with a 34 pin or greater port on the card or back panel to 
>bring out all 3 ports, and a suitable linux compatible driver for it?
>
3 possibilities: (there are more, including some with industrial 
protection, isolation, etc.)

www.computerboards.com : PCI-DIO24 and PCI-DIO24H, $89.  These are 
basically a single 8255 connected to the bus through a PCI glue chip.  
They don't seem to provide a driver, but I would think the board would 
be set up automatically by the PCI code, and then there are just the 
standard 4 ports to read/write (you just have to find the base address 
theough the PCI subsystem).

www.ni.com : NI-PCI-6503, $145.  This is a 24 I/O board, but has added 
logic (like a programmable power-on I/O state).  There don't seem to be 
Linux drivers, but they may exist if you ask tech support.  (NI is 
fairly Linux-friendly - they made a LabView/Linux version).

www.byterunner.com : PCI-1284-P2, $39.95.  This is a dual IEEE1284 PCI 
parallel port card, with Linux drivers.  It's not quite what you're 
looking for, but it will give you 24 I/O's (16 bidir, 10 dedicated, 2 
interrupts).

Hope this helps
- Steve


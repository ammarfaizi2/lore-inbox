Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270079AbTHCUOE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 16:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270094AbTHCUOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 16:14:04 -0400
Received: from arava.co.il ([212.179.127.3]:58762 "HELO arava.co.il")
	by vger.kernel.org with SMTP id S270079AbTHCUOC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 16:14:02 -0400
Date: Sun, 3 Aug 2003 23:14:53 +0300 (IDT)
From: Matan Ziv-Av <matan@svgalib.org>
X-X-Sender: matan@matan
To: bert hubert <ahu@ds9a.nl>
cc: linux-kernel@vger.kernel.org, "" <akpm@osdl.org>, "" <devik@cdi.cz>
Subject: Re: [PATCH] Allow /dev/{,k}mem to be disabled to prevent kernel from
 being modified easily
In-Reply-To: <20030803180950.GA11575@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.50.0308032303010.8694-100000@matan>
References: <20030803180950.GA11575@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 3 Aug 2003, bert hubert wrote:

> After being gloriously rootkitted with a program coded by HTB author Martin
> Devera (lots of thanks, devik, your work is appreciated, I suggest you read
> up about Oppenheimer when disclaiming that you are 'just a coder'. The item
> to google on is: "ethics sweetness hydrogen bomb Oppenheimer"), I wrote
> a patch to disable /dev/kmem and /dev/mem, which is harmless on servers
> without X.

For running X when /dev/mem is disabled, a solution can /dev/svga 
device, that I wrote for svgalib. It allows mmap access like 
/dev/mem, but only for VGA cards related memory - PCI regions that 
belong to VGA cards, and 0-0x110000 (for drivers that use the bios).
Of course, depending on the video card and the system, access to the 
video card's registers might be equivalent to access to all system 
memory, but it does add another layer of security.

See the driver at 

http://www.arava.co.il/matan/svgalib/svgalib-1.9.17.tar.gz



-- 
Matan Ziv-Av.                         matan@svgalib.org


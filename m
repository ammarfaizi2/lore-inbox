Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266984AbSKQXNI>; Sun, 17 Nov 2002 18:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266978AbSKQXNI>; Sun, 17 Nov 2002 18:13:08 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:28181 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S266917AbSKQXNH>;
	Sun, 17 Nov 2002 18:13:07 -0500
Date: Mon, 18 Nov 2002 00:20:04 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Linux Scsi Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Why /dev/sdc1 doesn't show up...
Message-ID: <20021117232004.GA1779@win.tue.nl>
References: <20021117195258.GC3280@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021117195258.GC3280@redhat.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 17, 2002 at 02:52:58PM -0500, Doug Ledford wrote:

> Working on a fix.  Haven't decided how to do it yet.

I encountered similar phenomena with usb-storage.
I think the proper solution is to never automatically
scan for a partition table.
We perhaps need to do that at boot time, but in all other
cases user space can ask the kernel to read a partition table.
For usb-storage things work fairly well (for some kernels)
using
	blockdev --rereadpt /dev/sdx

Andries



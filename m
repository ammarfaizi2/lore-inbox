Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281237AbRKTSiD>; Tue, 20 Nov 2001 13:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281234AbRKTShx>; Tue, 20 Nov 2001 13:37:53 -0500
Received: from quattro-eth.sventech.com ([205.252.89.20]:17679 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S281215AbRKTShf>; Tue, 20 Nov 2001 13:37:35 -0500
Date: Tue, 20 Nov 2001 13:37:35 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: "Daniel I. Applebaum" <danapple@danapple.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: built-in USB /proc bug
Message-ID: <20011120133735.A32355@sventech.com>
In-Reply-To: <200111201750.fAKHoYa03354@danapple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200111201750.fAKHoYa03354@danapple.com>; from danapple@danapple.com on Tue, Nov 20, 2001 at 11:50:34AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2001, Daniel I. Applebaum <danapple@danapple.com> wrote:
> 
> I tried building a 2.4.13 kernel with USB support as built-in, instead
> of modules.  The system worked, and USB devices worked, but there were
> no entries in /proc/bus/usb Yes, I had enabled both /proc filesystem
> and USB /proc filesystem support.  When the same kernel was built but
> with USB support as modules, the /proc/bus/usb entries appear.
> 
> Although no expert in these matters, I suspect that when the USB
> subsystem is built-in, it is initialized before /proc is mounted, and
> the USB /proc filesystem support either turns itself off or puts the
> "files" elsewhere.
> 
> A viable solution might be to have make menuconfig warn against this
> combination.

The problem is likely that it's a filesystem and you need to mount it
after loading the module.

Try running:

mount /proc/bus/usb

JE


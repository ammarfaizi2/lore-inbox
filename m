Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261312AbSJLRyp>; Sat, 12 Oct 2002 13:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261313AbSJLRyp>; Sat, 12 Oct 2002 13:54:45 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:59284 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S261312AbSJLRyo>;
	Sat, 12 Oct 2002 13:54:44 -0400
Date: Sat, 12 Oct 2002 20:00:32 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Alastair Stevens <alastair@camlinux.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Small oddity of the week: 2.4.20-pre
Message-ID: <20021012180032.GA22980@win.tue.nl>
References: <1034431251.2688.64.camel@dolphin.entropy.net> <20021012171642.GA22969@win.tue.nl> <1034443816.10850.70.camel@dolphin.entropy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1034443816.10850.70.camel@dolphin.entropy.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2002 at 06:30:15PM +0100, Alastair Stevens wrote:
> > >     fdisk -l | grep -w "/dev/hda6"
> > > 
> > > For some reason, this now produces, entirely at _random_, either one or
> > > two lines of output! It was the duplicated output that broke Mindi.
> 
> Here's a typical output:
> 
> 1 root@dolphin:/home/alastair> fdisk -l | grep -w "/dev/hda6"
> /dev/hda6          4419      4749   2658726   83  Linux
> /dev/hda6          4419      4749   2658726   83  Linux
> 2 root@dolphin:/home/alastair> fdisk -l | grep -w "/dev/hda6"
> /dev/hda6          4419      4749   2658726   83  Linux
> 3 root@dolphin:/home/alastair> fdisk -l | grep -w "/dev/hda6"
> /dev/hda6          4419      4749   2658726   83  Linux
> 4 root@dolphin:/home/alastair> fdisk -l | grep -w "/dev/hda6"
> /dev/hda6          4419      4749   2658726   83  Linux
> 
> ie - the first time, it gives me two repeated lines. This appears to be
> random. In a clean terminal, it'll sometimes give me only the one line
> on the first run, and then do two lines multiple times....

Could it be that you have statistics garbage in /proc/partitions?
That will break fdisk.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266953AbTAZQJE>; Sun, 26 Jan 2003 11:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266955AbTAZQJE>; Sun, 26 Jan 2003 11:09:04 -0500
Received: from coffee.Psychology.mcmaster.ca ([130.113.218.59]:24484 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S266953AbTAZQJE>; Sun, 26 Jan 2003 11:09:04 -0500
Date: Sun, 26 Jan 2003 11:18:20 -0500 (EST)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: hahn@coffee.psychology.mcmaster.ca
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: ATA TCQ  problems in 2.5.59
In-Reply-To: <200301261605.00539.roy@karlsbakk.net>
Message-ID: <Pine.LNX.4.44.0301261116390.16853-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm trying to turn on TCQ on 2.5.59, but it doesn't seem be able to set it to 
> anything but 0 and 1. This is with TCQ default 'off':
> 
> # cat /proc/ide/hda/settings | grep using_tcq
> using_tcq               0               0               32              rw
> # echo using_tcq:32 > /proc/ide/hda/settings
> # cat /proc/ide/hda/settings | grep using_tcq
> using_tcq               1               0               32              rw

but it's a flag, not a count.  use CONFIG_BLK_DEV_IDE_TCQ_DEPTH
if you want something other than the default depth of 1.


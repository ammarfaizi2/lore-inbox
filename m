Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261191AbTC0TMc>; Thu, 27 Mar 2003 14:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261340AbTC0TMc>; Thu, 27 Mar 2003 14:12:32 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:34828 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261191AbTC0TMb>; Thu, 27 Mar 2003 14:12:31 -0500
Date: Thu, 27 Mar 2003 20:23:43 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: 64-bit kdev_t - just for playing
In-Reply-To: <UTC200303270109.h2R19ME28410.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0303271956550.12110-100000@serv>
References: <UTC200303270109.h2R19ME28410.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 27 Mar 2003 Andries.Brouwer@cwi.nl wrote:

> kdev_t is the kernel-internal representation
> dev_t is the kernel idea of the user space representation
> (of course glibc uses 64 bits, split up as 8+8 :-)
> 
> kdev_t can be equal to dev_t.
> 
> The file below completely randomly makes kdev_t
> 64 bits, split up 32+32, and dev_t 32 bits, split up 12+20.

It would really help, if you would explain how a larger dev_t will work 
during 2.6.
Let's take an example, the first user is likely the scsi layer, so how 
can I manage thousands of disks under 2.6?
How are these disks registered and how will the dev_t number look like?
How will the user know about these numbers?
Who creates these device entries (user or daemon)?
How have user space utilities to be changed, which know about dev_t (e.g. 
ls or fdisk)?
How is backward compatibility done, so that I can still boot a 2.4 kernel?

bye, Roman


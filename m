Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267831AbTAHSQR>; Wed, 8 Jan 2003 13:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267836AbTAHSQR>; Wed, 8 Jan 2003 13:16:17 -0500
Received: from stroke.of.genius.brain.org ([206.80.113.1]:2241 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S267831AbTAHSQP>; Wed, 8 Jan 2003 13:16:15 -0500
Date: Wed, 8 Jan 2003 13:24:45 -0500
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: Re: USB CF reader reboots PC
Message-ID: <20030108182445.GC1189@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030108165130.GA1181@Master.Wizards> <20030108181645.GC3127@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030108181645.GC3127@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2003 at 10:16:45AM -0800, Greg KH wrote:
> On Wed, Jan 08, 2003 at 11:51:30AM -0500, Murray J. Root wrote:
> > devfs=mount in lilo.conf
> >               
> > Insert CF card. 
> > ls /dev shows sda and sda1
> > mount it. 
> > ls /dev shows sda - no sda1
> > cd to mounted CF card
> > process hangs, sd-mod & usb-storage "busy"
> > rmmod -f usb-storage or sd-mod causes PC to stop
> > (keyboard & mouse unresponsive, wmfire frozen, net disconnects)
> > 
> > reboot
> > Insert CF card. 
> > ls /dev shows sda & sda1
> > mount it. 
> > ls /dev shows sda - no sda1
> > umount it
> > ls /dev shows sda - no sda1
> > modprobe -r sd-mod && modprobe sd-mod 
> > ls /dev shows sda & sda1
> 
> So if devfs is enabled, everything works just fine?
> 
How did you come to that conclusion?
sda1 is where the data is - when I mount the CF sda1 disappears
from /dev and accessing the mountpoint hangs the process.

-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.freenode.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker
  #cooker = moderated Mandrake Cooker


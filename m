Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267556AbRGXPGr>; Tue, 24 Jul 2001 11:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267559AbRGXPGg>; Tue, 24 Jul 2001 11:06:36 -0400
Received: from haybaler.sackheads.org ([209.133.38.16]:51978 "HELO
	haybaler.sackheads.org") by vger.kernel.org with SMTP
	id <S267556AbRGXPGa>; Tue, 24 Jul 2001 11:06:30 -0400
Date: Tue, 24 Jul 2001 11:06:35 -0400
From: Jimmie Mayfield <mayfield+usenet@sackheads.org>
To: Mike Black <mblack@csihq.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Interesting disk throughput performance problem
Message-ID: <20010724110635.A28268@sackheads.org>
In-Reply-To: <20010721233313.A15232@sackheads.org> <016201c1129b$4e459b60$b6562341@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <016201c1129b$4e459b60$b6562341@cfl.rr.com>; from mblack@csihq.com on Sun, Jul 22, 2001 at 06:44:38AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sun, Jul 22, 2001 at 06:44:38AM -0400, Mike Black wrote:
> Not enough info (plenty for guessing though :-)
> 
> First off show "hdparm -i /dev/hd_" and "hdparm /dev/hd_" -- this will
> ensure both drives have things like DMA, etc.
> Next -- you didn't say what benchmarks you're using locally.
> And as the previous poster said provide "cat /proc/interrupts".

/proc/interrupts looks like this:
           CPU0       
  0:   17319250          XT-PIC  timer
  1:      85980          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:    1084144          XT-PIC  ide3, usb-uhci, usb-uhci
  6:        811          XT-PIC  floppy
  9:    1284463          XT-PIC  mga@PCI:1:0:0
 10:     142416          XT-PIC  eth0
 11:    8296678          XT-PIC  eth1, C-Media PCI CM8738
 12:     385915          XT-PIC  PS/2 Mouse
 15:          7          XT-PIC  ide1
NMI:          0 
LOC:   17319087 
ERR:       3022
MIS:          0


I would like to make a correction to my original post.  In that post I said 
that the drives are "masters" on their own controller.  This was false.  
They share a controller (CMD 649) with the Maxtor drive being "master" and 
the IBM drive being "slave".  To test if this was the problem, I reran the
tests (see URL below) with the IBM drive completely disconnected.  I didn't 
notice any difference.

I collected my benchmarks and tests into a simple webpage to avoid cluttering
this list.  Hopefully someone will see something obvious that I've 
misconfigured.

http://sackheads.org/~mayfield/dp.html


Jimmie

-- 
Jimmie Mayfield  
http://www.sackheads.org/mayfield       email: mayfield+usenet@sackheads.org
My mail provider does not welcome UCE -- http://www.sackheads.org/uce


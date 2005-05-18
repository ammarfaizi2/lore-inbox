Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262112AbVERHEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbVERHEK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 03:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbVERHEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 03:04:09 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:61105 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262112AbVERHEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 03:04:04 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: Sync option destroys flash!
Date: Wed, 18 May 2005 10:03:29 +0300
User-Agent: KMail/1.5.4
Cc: mhw@wittsend.com, linux-kernel@vger.kernel.org
References: <1116001207.5239.38.camel@localhost.localdomain> <200505152200.26432.vda@ilport.com.ua> <20050516231839.GB8032@hh.idb.hist.no>
In-Reply-To: <20050516231839.GB8032@hh.idb.hist.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505181003.29501.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 May 2005 02:18, Helge Hafting wrote:
> On Sun, May 15, 2005 at 10:00:26PM +0300, Denis Vlasenko wrote:
> > 
> > What we really need, is a less thorough version of O_SYNC.
> > O_SYNC currently guarantees that when syscall returns, data
> > is on media (or at least in disk drive's internal cache :).
> > 
> > This is exactly what really paranoid people want.
> > Journalling labels, all that good stuff.
> > 
> > But there are many cases where people just want to say
> > 'write out dirty data asap for this device', so that
> > I can copy files to floppy, wait till it stops making
> > noise, and eject a disk. Samr for flash if it has write
> > indicator (mine has a diode).
> > 
> I don't really see the need for a new mode.
> Mount without o_sync, but use the sync command
> once to get things written out.  Or
> use the umount command before ejecting, it syncs
> the device before returning.  I use umount all the time
> when using compactflash. The wear is minimal.

I just want this to happen automatically
(automounter helps with this) and at once
(i.e. without delay prior to start of writeout).

Caching (delaying) writes for hard disks makes tons of sense,
but not as much for removable media.
--
vda


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261967AbVEPXNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbVEPXNc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 19:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVEPXNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 19:13:32 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:20234 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261967AbVEPXN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 19:13:28 -0400
Date: Tue, 17 May 2005 01:18:39 +0200
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: mhw@wittsend.com, linux-kernel@vger.kernel.org
Subject: Re: Sync option destroys flash!
Message-ID: <20050516231839.GB8032@hh.idb.hist.no>
References: <1116001207.5239.38.camel@localhost.localdomain> <200505152200.26432.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505152200.26432.vda@ilport.com.ua>
User-Agent: Mutt/1.5.9i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2005 at 10:00:26PM +0300, Denis Vlasenko wrote:
> 
> What we really need, is a less thorough version of O_SYNC.
> O_SYNC currently guarantees that when syscall returns, data
> is on media (or at least in disk drive's internal cache :).
> 
> This is exactly what really paranoid people want.
> Journalling labels, all that good stuff.
> 
> But there are many cases where people just want to say
> 'write out dirty data asap for this device', so that
> I can copy files to floppy, wait till it stops making
> noise, and eject a disk. Samr for flash if it has write
> indicator (mine has a diode).
> 
I don't really see the need for a new mode.
Mount without o_sync, but use the sync command
once to get things written out.  Or
use the umount command before ejecting, it syncs
the device before returning.  I use umount all the time
when using compactflash. The wear is minimal.

Helge Hafting



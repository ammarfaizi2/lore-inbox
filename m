Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbULGSrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbULGSrT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 13:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261894AbULGSrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 13:47:19 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:40847 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261880AbULGSrJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 13:47:09 -0500
Message-Id: <200412031750.iB3Hot3q002538@falcon10.austin.ibm.com>
X-Mailer: exmh version 2.7.1.1 10/09/2004 with nmh-1.1
In-reply-to: <20041203172214.GA28067@animx.eu.org> 
To: Wakko Warner <wakko@animx.eu.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: USB DVD ... Again. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 Dec 2004 11:50:55 -0600
From: Doug Maxey <dwm@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 03 Dec 2004 12:22:14 EST, Wakko Warner wrote:
>I'm about lost onthis one =)
>
>----- Forwarded message from Alan Stern <stern@rowland.harvard.edu> -----
>
>Date: Fri, 3 Dec 2004 10:22:43 -0500 (EST)
>From: Alan Stern <stern@rowland.harvard.edu>
>To: Wakko Warner <wakko@animx.eu.org>
>cc: linux-usb-devel@lists.sourceforge.net
>Subject: Re: [linux-usb-devel] FWD: Re: USB DVD
>
>On Thu, 2 Dec 2004, Wakko Warner wrote:
>
>> I have the debug information at
>> http://veg.animx.eu.org/usb-storage.debug.dvd.txt
>> It's around 190kb in size.
>> 
>> ----- Forwarded message from Greg KH <greg@kroah.com> -----
>> 
>> Date:	Fri, 26 Nov 2004 19:28:17 -0800
>> From: Greg KH <greg@kroah.com>
>> To: linux-kernel@vger.kernel.org
>> Subject: Re: USB DVD
>> X-Mailing-List:	linux-kernel@vger.kernel.org
>> 
>> On Thu, Nov 25, 2004 at 10:03:13AM -0500, Wakko Warner wrote:
>> > I have a USB DVD writer (I don't think the 'writer' part makes a difference)
>> > that when I attempt to view a DVD Movie, it can't read some of the sectors
>> > (DVD Auth I guess).  The same drive internally on ide works.  Is a problem
>> > with USB or the enclosure?
>> 
>> Odds are it's the enclosure :)
>> 
>> But to be sure, can you enable CONFIG_USB_STORAGE_DEBUG and send the
>> resulting log to the linux-usb-devel mailing list?
>
>It's not a USB problem.  The device is returning an error code with sense 
>key = 0x05 (Illegal Request) and ASC/ASCQ = 0x6f, 0x04 (I don't know what 
>those mean).  Maybe someone who is familiar with the SCSI DVD protocol can 
>explain.  However it's clear that the low-level USB transport is working 
>without errors.
>
>Alan Stern

Official definition:
6F/04 - MEDIA REGION CODE IS MISMATCHED TO LOGICAL UNIT REGION

05 - Illegal Request

Means that a value was set in the cdb to do an operation the drive could 
not handle.

++doug


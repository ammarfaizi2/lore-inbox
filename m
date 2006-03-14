Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752047AbWCNXDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbWCNXDA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 18:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751636AbWCNXDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 18:03:00 -0500
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:43471 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1750734AbWCNXC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 18:02:59 -0500
Message-ID: <44174DA0.5020105@gentoo.org>
Date: Tue, 14 Mar 2006 23:11:28 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mail/News 1.5 (X11/20060207)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Peter Chubb <peterc@gelato.unsw.edu.au>, linux-kernel@vger.kernel.org,
       autophile@starband.net, stern@rowland.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: HP CDRW CD4E hasn't worked since 2.6.11
References: <17430.14259.90181.849542@berry.ken.nicta.com.au> <20060314221958.GD12257@suse.de>
In-Reply-To: <20060314221958.GD12257@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, Mar 14, 2006 at 02:25:39PM +1100, Peter Chubb wrote:
>> Hi Greg,
>> 	The changes to the usb/storage/shuttle_usbat.c to accomodate
>> flash drives appears to have broken CD R/W support.
>>
>> Sorry it took me so long to report this; I don't use this particular
>> device very often.
>>
>> Compiling with verbose debug shows that the IDENTIFY_PACKET_DEVICE
>> command is failing, so the device is mis-identified as a flash drive.
>>
>> I went to the start of the Git history in Linus's tree; 2.6.12 also
>> fails.

I think it may have worked for you on-and-off in the middle of those 
changes. It's been a nightmare trying to get both device types 
identified correctly.

>> I tried to force the detection, to see if I could get past that point,
>> but there are still problems -- see the attached logs -- the device is
>> recognised as a scsi disk not cdrom.

Can you detail your changes? I'm not convinced by this, because I have 
been careful not to change any HP8200-specific code (except the 
detection), and also, I don't think it is possible for the device to 
appear as a disk if the HP8200 codepath is being followed.

There was one other report of this but my emails to that reporter were 
bouncing so I left this in my todo mailbox.

Daniel

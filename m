Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261527AbSIXBu4>; Mon, 23 Sep 2002 21:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261530AbSIXBu4>; Mon, 23 Sep 2002 21:50:56 -0400
Received: from web40013.mail.yahoo.com ([66.218.78.53]:12561 "HELO
	web40013.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261527AbSIXBuv>; Mon, 23 Sep 2002 21:50:51 -0400
Message-ID: <20020924015559.45518.qmail@web40013.mail.yahoo.com>
Date: Mon, 23 Sep 2002 18:55:59 -0700 (PDT)
From: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: Atech Pro II flash card reader(s)
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net
In-Reply-To: <20020908231001.GA11472@win.tue.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Andries,

--- Andries Brouwer <aebr@win.tue.nl> wrote:
> On Sun, Sep 08, 2002 at 03:53:22PM -0700, Brad Chapman wrote:
> > I am trying to make an Atech Pro II card reader work under Linux.
> 
> The USB device database says:
> 
> This device can be made fully functional with the addition of the following
> entry
> to /usr/src/linux/drivers/usb/storage/unusual_devs.h:
> 
> UNUSUAL_DEV( 0x0aec,0x5010,0x0000,0x1a00, "Atech", "Pro II MultiCard",
> 	US_SC_SCSI, US_PR_BULK, NULL, US_FL_FIX_INQUIRY ),
> 
> Try, and report. If this works it should be added to the stock kernel.
> The numbers given are 0x0aec: Vendor ID, 0x5010: Product ID, 0x0000-0x1a00:
> Revisions. If you have a later revision, increase 0x1a00, or just write
> 0xffff.

       Sorry for taking so long to report back,but I've been busy.

       Results: Adding the above macro entry to line 82 of unusual_devs.h
(2.4.19) resulted in the flash reader being detected by usb_storage. When
the sd_mod module was loaded, /dev/discs/disc1 snapped into being. I
accessed the CompactFlash drive as part1 with an 8MB VFAT-formatted unit and
was able to perform any filesystem operation needed.

       This should be pushed into a USB BK/CVS tree or even forwarded to
Marcelo. BTW, is there a way to keep sd_mod from failing to read the empty
drives?

Thanks,

Brad Chapman


__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com

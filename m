Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315483AbSIHXFb>; Sun, 8 Sep 2002 19:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315485AbSIHXFb>; Sun, 8 Sep 2002 19:05:31 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:29112 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S315483AbSIHXFa>;
	Sun, 8 Sep 2002 19:05:30 -0400
Date: Mon, 9 Sep 2002 01:10:01 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Brad Chapman <jabiru_croc@yahoo.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net
Subject: Re: Atech Pro II flash card reader(s)
Message-ID: <20020908231001.GA11472@win.tue.nl>
References: <20020908225322.55836.qmail@web40004.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020908225322.55836.qmail@web40004.mail.yahoo.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 08, 2002 at 03:53:22PM -0700, Brad Chapman wrote:
> I am trying to make an Atech Pro II card reader work under Linux.

The USB device database says:

This device can be made fully functional with the addition of the following entry
to /usr/src/linux/drivers/usb/storage/unusual_devs.h:

UNUSUAL_DEV( 0x0aec,0x5010,0x0000,0x1a00, "Atech", "Pro II MultiCard",
	US_SC_SCSI, US_PR_BULK, NULL, US_FL_FIX_INQUIRY ),

Try, and report. If this works it should be added to the stock kernel.
The numbers given are 0x0aec: Vendor ID, 0x5010: Product ID, 0x0000-0x1a00:
Revisions. If you have a later revision, increase 0x1a00, or just write
0xffff.

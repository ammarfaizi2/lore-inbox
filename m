Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261800AbSJUWqu>; Mon, 21 Oct 2002 18:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261801AbSJUWqu>; Mon, 21 Oct 2002 18:46:50 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:39904 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261800AbSJUWqt>;
	Mon, 21 Oct 2002 18:46:49 -0400
Date: Mon, 21 Oct 2002 15:52:37 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: andy barlak <andyb@island.net>
Cc: Mike Anderson <andmike@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi_error device offline fix
Message-ID: <20021021155236.A10032@eng2.beaverton.ibm.com>
Mail-Followup-To: andy barlak <andyb@island.net>,
	Mike Anderson <andmike@us.ibm.com>, linux-kernel@vger.kernel.org
References: <20021021193335.GE1069@beaverton.ibm.com> <Pine.LNX.4.30.0210211250340.12696-100000@tosko.alm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.30.0210211250340.12696-100000@tosko.alm.com>; from andyb@island.net on Mon, Oct 21, 2002 at 01:01:26PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 01:01:26PM -0700, andy barlak wrote:
> 
> Sorry,  used the wrong dmesg file for the copy and paste of the error message.
> 
> yes the printk error message issued is:
> 
> scsi: Device offlined - not ready or command retry failed after error recovery:
> host 0 channel 0 id 0 lun 0
> 
> over and over through all ids, existing or not.
> Patch was successfully applied to 2.5.44.

I thought it could be one of the INQUIRY related commands to get the
id/serial numbers, since in your (previous) dmesg output, the failure
occured after the print_inquiry() call on the same target before any
upper level attaches.

But now you are getting nothing at all, not even any of the print_inquiry()
output? 

Like you got just before the failures in your original message:

Vendor: CONNER    Model: CFP2107E  2.14GB  Rev: 1423
Type:   Direct-Access                      ANSI SCSI revision: 02
Vendor: SEAGATE   Model: SX423451W         Rev: 9E18
Type:   Direct-Access                      ANSI SCSI revision: 02

Can you turn on all scsi logging - with CONFIG_SCSI_LOGGING enabled,
on your boot command line add a "scsi_logging=1" and send
the output.

-- Patrick Mansfield

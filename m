Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315919AbSGPL4f>; Tue, 16 Jul 2002 07:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317550AbSGPL4e>; Tue, 16 Jul 2002 07:56:34 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:64393 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S315919AbSGPL4d>;
	Tue, 16 Jul 2002 07:56:33 -0400
Date: Tue, 16 Jul 2002 13:59:20 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Joerg Schilling <schilling@fokus.gmd.de>
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Message-ID: <20020716135920.B7352@ucw.cz>
References: <200207161128.g6GBSJPE021316@burner.fokus.gmd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200207161128.g6GBSJPE021316@burner.fokus.gmd.de>; from schilling@fokus.gmd.de on Tue, Jul 16, 2002 at 01:28:19PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2002 at 01:28:19PM +0200, Joerg Schilling wrote:

> It would help, if somebody would correct the current SCSI addressng scheme used 
> in Linux. Linux currently uses something called BUS/channel/target/lun.
> This does not reflect reality.
> 
> What Linux calls a SCSI bus is definitely not a SCSI bus but a SCSI HBA card.
> What Linux calls a channel really is one of possibly more SCSI busses going
> off one of the SCSI HBA cards. It makes sense to just count SCSI busses.

Well, no. It doesn't. Because the numbers will change if you add a card
(even at runtime - hotplugging USB SCSI is something real happening
today. And that'd be a very bad thing.

The way it'll be done is that you'll get the device physical path (see
driverfs) to the device, the device serial number and other identifiers
and then a hotplug/system configuration agent will choose a nice name
for it (completely configurable).

-- 
Vojtech Pavlik
SuSE Labs

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265499AbTFMTew (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 15:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265500AbTFMTew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 15:34:52 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:55447 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265499AbTFMTev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 15:34:51 -0400
Date: Fri, 13 Jun 2003 21:48:32 +0200
From: Vojtech Pavlik <vojtech@ucw.cz>
To: Michael Frank <mflt1@micrologica.com.hk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc7 hang on boot after spurious 8259A interrupt: IRQ15.
Message-ID: <20030613214832.A6366@ucw.cz>
References: <200306130958.39707.mflt1@micrologica.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200306130958.39707.mflt1@micrologica.com.hk>; from mflt1@micrologica.com.hk on Fri, Jun 13, 2003 at 11:36:36AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 11:36:36AM +0800, Michael Frank wrote:

> Doing swsusp testing in endless loop. On a P4/2.4G (ACPI=off)
> on 192nd boot:
> 
> spurious 8259A interrupt: IRQ15.
> Calibrating delay loop... 

It looks like the IDE code didn't put the controller into sleep
properly.

>  hang
> 
> Hit Reset and it rebooted OK
> 
> This is the first spurious 8259A interrupt: IRQ15 seen.
> 
> I see spurious 8259A interrupt: IRQ7 quite frequently on
> varying hardware on both 2.4 and 2.5.
> 
> By design, the 8259A delivers a vector 7 when the IRQ
> line is deasserted before the IRQ is serviced. This
> applies to both edge and level trigger modes. A floating
> "wire" or crapy chipset can pickup noise, but the driver 
> should handle it.  
> 
> No problems seen with mainboard/cpu/ram in three months. 
> I dont' think it is HW, but it could be.  
> 
> Also, spurious 8259A interrupts are quite recent, could 
> something be wrong with recent 8259A driver?
> 
> Regards
> Michael
> 
> I am not subscribed, pls cc me
> 
> -- 
> Powered by linux-2.5.70-mm3, compiled with gcc-2.95-3
> 
> My current linux related activities in rough order of priority:
> - Testing of 2.4/2.5 kernel interactivity
> - Testing of Swsusp for 2.4
> - Testing of Opera 7.11 emphasizing interactivity
> - Research of NFS i/o errors during transfer 2.4>2.5
> - Learning 2.5 series kernel debugging with kgdb - it's in the -mm tree
> - Studying 2.5 series serial and ide drivers, ACPI, S3
> * Input and feedback is always welcome *
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

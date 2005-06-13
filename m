Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbVFMWII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVFMWII (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 18:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbVFMWHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 18:07:02 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:32650 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261486AbVFMWFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 18:05:09 -0400
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Gregoire Favre <gregoire.favre@gmail.com>
Cc: dino@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050613215923.GA8629@gmail.com>
References: <20050530190716.GA9239@gmail.com>
	 <1118081857.5045.49.camel@mulgrave> <20050607085710.GB9230@gmail.com>
	 <1118590709.4967.6.camel@mulgrave> <20050613145000.GA12057@gmail.com>
	 <1118674783.5079.9.camel@mulgrave> <20050613183719.GA8653@gmail.com>
	 <1118695847.5079.41.camel@mulgrave> <20050613213307.GA8534@gmail.com>
	 <1118699191.5079.49.camel@mulgrave>  <20050613215923.GA8629@gmail.com>
Content-Type: text/plain
Date: Mon, 13 Jun 2005 17:04:44 -0500
Message-Id: <1118700284.5079.52.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-13 at 23:59 +0200, Gregoire Favre wrote:
>  target0:0:0: SC IS ffff81003fcaeac0
>  target0:0:0: ULTRA2, flags 0xc3bb
>  target0:0:0: scsirate IS 0x3, min_period is 10, flags 0xc3bb
>   Vendor: IBM       Model: DDRS-39130D       Rev: DC1B
>   Type:   Direct-Access                      ANSI SCSI revision: 02

Well ... just to confirm for this one: although it's on a u160
controller, you have its speed configured in bios to 40MHz (rather than
80Mhz)?  That's what the value of flags seems to say, and we look to be
interpreting it correctly.

James



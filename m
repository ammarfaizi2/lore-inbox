Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131665AbRDJMem>; Tue, 10 Apr 2001 08:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131666AbRDJMeb>; Tue, 10 Apr 2001 08:34:31 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:11026 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S131638AbRDJMct>; Tue, 10 Apr 2001 08:32:49 -0400
Message-Id: <200104101232.f3ACWes28977@aslan.scsiguy.com>
To: e-double@iname.com
cc: linux-kernel@vger.kernel.org, eweinstein@cya.com
Subject: Re: AIC7XXX oddities 
In-Reply-To: Your message of "Mon, 09 Apr 2001 23:14:29 EDT."
             <0104092314299F.00428@weba8.iname.net> 
Date: Tue, 10 Apr 2001 06:32:40 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>An invocation of hdparm -Tt /dev/sda (id 5) does this:
>
>(scsi1:A:1): 5.000MB/s transfers (5.000MHz, offset 15)
>(scsi1:A:6): 20.000MB/s transfers (20.000MHz, offset 15)
>(scsi0:A:5): 3.300MB/s transfers

The situation might be clearer if you run with aic7xxx=verbose.
My guess is that the target detected a CRC error a transaction
and negotiated async as an indication that the initiator should
perform domain validation on this bus segment again.  Unfortunatly,
the driver doesn't yet support domain validation, so you end up
being stuck at 3.3MB/s.  I would suggest looking for problems with
your cabling or termination on that controller.

--
Justin

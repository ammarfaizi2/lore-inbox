Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261750AbTCQQPw>; Mon, 17 Mar 2003 11:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261756AbTCQQPv>; Mon, 17 Mar 2003 11:15:51 -0500
Received: from fmr02.intel.com ([192.55.52.25]:10751 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S261750AbTCQQPu>; Mon, 17 Mar 2003 11:15:50 -0500
Message-ID: <A5974D8E5F98D511BB910002A50A66470580D6D1@hdsmsx103.hd.intel.com>
From: "Cress, Andrew R" <andrew.r.cress@intel.com>
To: "'Ingo Oeser'" <ingo.oeser@informatik.tu-chemnitz.de>,
       Terry Barnaby <terry@beam.ltd.uk>
Cc: Michael Madore <mmadore@aslab.com>, "Justin T. Gibbs" <gibbs@scsiguy.com>,
       linux-kernel@vger.kernel.org
Subject: RE: Reproducible SCSI Error with Adaptec 7902
Date: Mon, 17 Mar 2003 08:30:18 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

Our testing with that drive (same firmware, using same aic7902 chipset) has
not shown any problems like this.  However, we were using a later aic79xx
driver versions (1.3.x).  That upgrade should be the first step.

I wouldn't get too excited about the statement by a level-1 Seagate support
guy, probably just a blanket statement when they want to disclaim
responsibility.  

Andy

-----Original Message-----
From: Ingo Oeser [mailto:ingo.oeser@informatik.tu-chemnitz.de] 
Sent: Saturday, March 15, 2003 8:12 AM
To: Terry Barnaby
Cc: Michael Madore; Justin T. Gibbs; linux-kernel@vger.kernel.org
Subject: Re: Reproducible SCSI Error with Adaptec 7902


On Fri, Mar 14, 2003 at 04:17:59PM +0000, Terry Barnaby wrote:
> The Seagate ST336607LW has firmware: 0004.
> Seagate have stated to me that this is the latest.
> They have also stated to me:
> 
>   Issuing an unrecognized or illegal command to the drive can cause the
>   drive to go into a hardware fault mode where it will no longer respond,
>   and may or may not respond to a SCSI BUS reset. It seems, in this case,
>   the drive will no longer respond to any commands issued by the
>   controller.
> 
> Is this "feature" now common on SCSI drives ????

Could we add a KERN_WARNING printk in sd.c quoting/referencing
this message on inquiry detecting this device? 

So sysadmins who are used to SCSI being robust could return the
drive to their vendors in exchange to a drive working along the
SCSI specs after reading this message.

Thanks in the name of the sysadmins.

Regards

Ingo Oeser
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

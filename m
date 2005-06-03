Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVFCPEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVFCPEA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 11:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbVFCPEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 11:04:00 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:16064 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261314AbVFCPDi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 11:03:38 -0400
Subject: Re: TPM on IBM thinkcenter S51
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Torsten Landschoff <tla@comsys.informatik.uni-kiel.de>
Cc: trusted linux <tcimpl2005@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1117790588.6249.5.camel@localhost.localdomain>
References: <20050602220028.3572.qmail@web61014.mail.yahoo.com>
	 <1117790588.6249.5.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 03 Jun 2005 10:02:49 -0500
Message-Id: <1117810969.5407.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Torsten,

I maintain the driver and am interested in figuring out what this
problem is.  Can you please tell me what the device major/minor are
on /dev/tpm.  Any output produced by the driver in /var/log/messages.
Also the output of /sbin/lspci.  Also I am assuming you are using the
version in the default 2.6.12-rc5.  There are many changes are in the -
mm2 patch so I will pull down the default tree and make sure the version
there is working.

Thanks,
Kylie

On Fri, 2005-06-03 at 11:23 +0200, Torsten Landschoff wrote:
> On Thu, 2005-06-02 at 15:00 -0700, trusted linux wrote:
> > thanks, here is my strace related to tpm:
> > 
> > open("/dev/tpm", O_RDWR)                = -1 ENODEV
> > (No such device)
> > write(2, "Can\'t open TPM Driver\n", 22Can't open TPM
> > Driver
> > ) = 22
> 
> Okay, so the driver is in fact not working. It could be that /dev/tpm
> has the wrong device number assigned. If the driver is really installed
> can be checked by
> 
> 	systool -c misc|grep tpm
> 
> I bet it does not show anything. OTOH if the module loads successfully
> it really should be there. No idea what's going wrong then. 
> 
> Which version of the driver are you using?
> 
> Greetings
> 
> 	Torsten
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267743AbTBGIjZ>; Fri, 7 Feb 2003 03:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267739AbTBGIjZ>; Fri, 7 Feb 2003 03:39:25 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:20623 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267738AbTBGIjX>; Fri, 7 Feb 2003 03:39:23 -0500
Date: Fri, 7 Feb 2003 00:50:43 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: Anton Blanchard <anton@samba.org>
Cc: Patrick Mansfield <patmans@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Broken SCSI code in the BK tree (was: 2.5.59-mm8)
Message-ID: <20030207085043.GA2001@beaverton.ibm.com>
Mail-Followup-To: Anton Blanchard <anton@samba.org>,
	Patrick Mansfield <patmans@us.ibm.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	James Bottomley <James.Bottomley@steeleye.com>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <211570000.1044508407@[10.10.2.4]> <265170000.1044564655@[10.10.2.4]> <275930000.1044570608@[10.10.2.4]> <1044573927.2332.100.camel@mulgrave> <20030206172434.A15559@beaverton.ibm.com> <293060000.1044583265@[10.10.2.4]> <20030206182502.A16364@beaverton.ibm.com> <20030206230544.E19868@redhat.com> <20030207041936.GA26189@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030207041936.GA26189@krispykreme>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I removed the other Mike Anderson (mikeand@us.ibm.com) from the cc
list, we seem to have many Mike Anderson's around hear :-).

Anton Blanchard [anton@samba.org] wrote:
>  
> Hi,
> 
> > If I understand correctly, Matthew Jacob's latest isp driver set drives
> > *all* qlogic hardware (or at least all the older stuff like the qlogicisp
> > driver drives).  I would much prefer that people simply test out Matthew's
> > driver and use it instead.  In fact, if it's ready for 2.5 kernel use, I
> > would strongly recommend that it be considered as a possible replacement
> > in the linux kernel for the default driver on all qlogic cards not handled
> > by the new qla2x00 driver version 6 (DaveM may have objections to that 
> > related to sparc if Matthew's driver isn't sparc friendly, but I don't 
> > know of any other reason not to switch over).
> 
> I had a bunch of problems with the in kernel and vendor qlogic drivers
> on my ppc64 box. Matt Jacob's driver worked out of the box. Davem
> sounded positive last time I asked him about it.
> 
> I did a quick forward port to 2.5 a month or two ago, sounds like we
> should work to get it in the kernel. There are some rough edges but
> Mike kindly offered to lend a hand here.

I have been buried lately so I have only taken the patch you sent me
and updated it so it will compile with the most recent SCSI
changes. I also made a few tweaks to the make files.

Currently it is running on my 2202 card system.

When I ran it my other system that has a Qlogic ISP1020 and two Qlogic
2300's it would hang post initing the driver. The driver seemed to be
responsive to external events like port downs, but appeared to not
complete its init. When I use the driver disable defines to turn off
detection of the ISP1020 the driver loaded ok (I only ran it up to 60MB
on a few spindles so not a very good test).

I will look at this more and see if I can understand the cause.

-andmike
--
Michael Anderson
andmike@us.ibm.com


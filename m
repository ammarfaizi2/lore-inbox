Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbUBKCOT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 21:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbUBKCOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 21:14:19 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:40109 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id S262913AbUBKCOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 21:14:16 -0500
Date: Tue, 10 Feb 2004 17:36:23 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Andrew Vasquez <praka@users.sourceforge.net>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, veeresh <vanami@india.hp.com>
Subject: Re: Kernel panic on Redhat Linux AS2.1 with QLogic 2342 HBA
Message-ID: <20040211013623.GN4902@ca-server1.us.oracle.com>
Mail-Followup-To: Andrew Vasquez <praka@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	veeresh <vanami@india.hp.com>
References: <005601c3ef94$f8c9d140$3bda4c0f@nt21859> <20040210182513.GA114@praka.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210182513.GA114@praka.local.home>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-White-List-Member: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 10:25:13AM -0800, Andrew Vasquez wrote:
> On Tue, 10 Feb 2004, veeresh wrote:
> 
> > Kernel panic information:
> > kernel BUG at /usr/src/linux-2.4/include/asm/pci.h:145!
> > invalid operand: 0000
> > Kernel 2.4.9-e.25smp
> > CPU: 2
> > EIP: 0010:[<f8891658>] Tainted: P
> > EFLAGS: 00010086
> > EIP is at qla2x00_64bit_start_scsi [qla2300] 0x498
> 
> One of the scatter-gather entries of a SCSI command was NULL.  Is any
> of the software you are running preparing SCSI commands and sending
> them down via SG perhaps?  What type of I/O is occuring when the
> failure occurs?

Andrew,
	This appears to be the same bug we discussed a while back.  I
thought QLogic was working on a fix?  We saw it with absolutely no SG
involved.  It was something to do with error retry, wasn't it?

Joel

-- 

 Brain: I shall pollute the water supply with this DNAdefibuliser,
        turning everyone into mindless slaves.
 Pinky: What about the people who drink bottled water?
 Brain: Pinky, people who pay 5 dollars for a bottle of water are
        already mindless slaves.

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

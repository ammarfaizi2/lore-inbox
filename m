Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbTDKTGW (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 15:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbTDKTGV (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 15:06:21 -0400
Received: from inet-mail1.oracle.com ([148.87.2.201]:5791 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id S261528AbTDKTGT (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 15:06:19 -0400
Date: Fri, 11 Apr 2003 11:35:43 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, Giuliano Pochini <pochini@shiny.it>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Mike Anderson <andmike@us.ibm.com>
Subject: Re: [patch for playing] Patch to support 4000 disks and maintain
Message-ID: <20030411183543.GA31739@ca-server1.us.oracle.com>
References: <200304101339.49895.pbadari@us.ibm.com> <XFMail.20030411100430.pochini@shiny.it> <20030411154450.GW31739@ca-server1.us.oracle.com> <200304110928.32978.pbadari@us.ibm.com> <20030411175736.GY31739@ca-server1.us.oracle.com> <20030411111232.A7756@beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030411111232.A7756@beaverton.ibm.com>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 11:12:32AM -0700, Patrick Mansfield wrote:
> I'm trying to pull the current multi-path patch up to 2.5.66 (ouch). 

	I wasn't aware of this work.  This is very interesting.  Two
questions:

1) When does it failover?  Meaning, if I I/O to a disk, but someone
yanks the fibrechannel plug.  Does your multipath wait for a SCSI
timeout to redirect the I/O?

2) If so, have you considered trapping loop up/down events to handle
such a case?  Real users of multipath tech do not want to wait 90s for
failover.

Joel

-- 

"Win95 file and print sharing are for relatively friendly nets."
        - Paul Leach, Microsoft

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

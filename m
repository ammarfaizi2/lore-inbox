Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752196AbWJNULQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196AbWJNULQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 16:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752197AbWJNULQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 16:11:16 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:20304 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1752193AbWJNULP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 16:11:15 -0400
Date: Sat, 14 Oct 2006 13:10:16 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, Chandra Seetharaman <sekharan@us.ibm.com>,
       ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Allow more than PAGESIZE data read in configfs
Message-ID: <20061014201016.GG2747@ca-server1.us.oracle.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
	Chandra Seetharaman <sekharan@us.ibm.com>,
	ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain> <20061010203511.GF7911@ca-server1.us.oracle.com> <20061011131935.448a8696.akpm@osdl.org> <20061011221822.GD7911@ca-server1.us.oracle.com> <20061011154836.9befa359.akpm@osdl.org> <1160609233.6389.82.camel@linuxchandra> <20061014080107.GB19325@kroah.com> <20061014124351.63434962.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061014124351.63434962.akpm@osdl.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2006 at 12:43:51PM -0700, Andrew Morton wrote:
> On Sat, 14 Oct 2006 01:01:07 -0700
> Greg KH <greg@kroah.com> wrote:
> > Argh!!!!
> > 
> > Are you going to honestly tell me you have a single attribute in sysfs
> > that is larger than PAGE_SIZE?
> 
> He does not.  It's a matter of reusing existing facilities rather than
> impementing similar things in multiple places.  The equivalent patch in
> configfs removed a decent amount of code:

	Issues of PAGE_SIZE and attribute size aside, the patch posted
was incorrect.  While they used seq_file, they implemented it in a
completely inefficent fashion, filling the entire buffer in one ->show()
call rather than letting multiple read(2) calls iterate their list.

Joel

-- 

"Anything that is too stupid to be spoken is sung."  
        - Voltaire

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbTDKSE5 (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 14:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbTDKSE4 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 14:04:56 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:59834 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261390AbTDKSEp (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 14:04:45 -0400
Date: Fri, 11 Apr 2003 11:12:32 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, Giuliano Pochini <pochini@shiny.it>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Mike Anderson <andmike@us.ibm.com>
Subject: Re: [patch for playing] Patch to support 4000 disks and maintain
Message-ID: <20030411111232.A7756@beaverton.ibm.com>
References: <200304101339.49895.pbadari@us.ibm.com> <XFMail.20030411100430.pochini@shiny.it> <20030411154450.GW31739@ca-server1.us.oracle.com> <200304110928.32978.pbadari@us.ibm.com> <20030411175736.GY31739@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030411175736.GY31739@ca-server1.us.oracle.com>; from Joel.Becker@oracle.com on Fri, Apr 11, 2003 at 10:57:37AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 10:57:37AM -0700, Joel Becker wrote:

> > Fortunately, the multipath solution Mike Anderson & Patrick Mansfield
> > working on, colapses all the disks you see thro multiple paths into 
> > number of  realdisks (4000). So you don't really need extra devices 
> > to support multipathing.
> 
> 	Yes, but what if I want to see the multiple paths?  Does their
> solution allow you to specify the path behind the 'realdisk'?  Does it
> allow querying of the paths?
> 
> Joel

Seeing the path to disk relationship - yes (via proc for now, eventually
via sysfs).

Specifying from user space what path goes with what disk (explicitly): no,
that might require user level scanning.

Query a path - seeing and setting path states yes (via proc right now).
Using sg with a specified path - no, but on the TODO list.

I'm trying to pull the current multi-path patch up to 2.5.66 (ouch). 

The last functioning patch was against 2.5.59, some general info:

http://www-124.ibm.com/storageio/multipath/scsi-multipath/index.php

Or the patch:

http://www-124.ibm.com/storageio/multipath/scsi-multipath/releases/2.5.59-mpath-1.patch.gz

-- Patrick Mansfield

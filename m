Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262727AbTDKXyd (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 19:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262734AbTDKXyd (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 19:54:33 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:60033 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id S262727AbTDKXyb (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 19:54:31 -0400
Date: Fri, 11 Apr 2003 17:04:37 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Greg KH <greg@kroah.com>
Cc: David Lang <david.lang@digitalinsight.com>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Jeremy Jackson'" <jerj@coplanar.net>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-hotplug-devel@lists.sourceforge.net'" 
	<linux-hotplug-devel@lists.sourceforge.net>
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030412000436.GE4917@ca-server1.us.oracle.com>
References: <A46BBDB345A7D5118EC90002A5072C780BEBAA44@orsmsx116.jf.intel.com> <Pine.LNX.4.44.0304111347370.8422-100000@dlang.diginsite.com> <20030411205948.GV1821@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030411205948.GV1821@kroah.com>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 01:59:48PM -0700, Greg KH wrote:
> You can store the default permissions in the database you use to store
> the naming data.  This solves the reboot problem, as long as you can
> convince people to not modify the permissions on their own (well even if
> they do, at shutdown, you can always validate that they are the same
> before you clean up the node.)

	There is no reason this can't live on ext3.  The permissions are
always right.  At device insertion, udev sees that the new device is
'disk0' and modifies /dev/disk0 to point to the new device (whatever
number).  Permissions are preserved.

Joel

-- 

"The whole principle is wrong; it's like demanding that grown men 
 live on skim milk because the baby can't eat steak."
        - author Robert A. Heinlein on censorship

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

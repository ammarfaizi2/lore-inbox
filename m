Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288747AbSADUwE>; Fri, 4 Jan 2002 15:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288758AbSADUvy>; Fri, 4 Jan 2002 15:51:54 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:52989 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S288747AbSADUvr>;
	Fri, 4 Jan 2002 15:51:47 -0500
Date: Fri, 4 Jan 2002 13:51:29 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel log messages using wrong timezone
Message-ID: <20020104135129.Q12868@lynx.no>
Mail-Followup-To: Chris Friesen <cfriesen@nortelnetworks.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C360D22.F6FFFAD6@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3C360D22.F6FFFAD6@nortelnetworks.com>; from cfriesen@nortelnetworks.com on Fri, Jan 04, 2002 at 03:14:26PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 04, 2002  15:14 -0500, Chris Friesen wrote:
> How does the kernel figure out how to timestamp the log output?
> The reason I'm asking is that we have a system that has /etc/localtime
> pointing to the Americas/Montreal timezone, but the log output from the
> kernel appears to be UTC.

The kernel doesn't timestamp the logs, AFAIK.  That is done by syslog when
it writes the logs to disk.  If you check "dmesg" output - no timestamps.

> Can anyone point me to the right place to deal with this?

Restart syslog so that it notices the new timezone, or something else, I
don't know.  IIRC, you are the one doing strange things with syslog.
Are you doing network syslog logging now?  Are both of your hosts running
with the same timezone?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/


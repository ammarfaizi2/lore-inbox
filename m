Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285007AbSADV5w>; Fri, 4 Jan 2002 16:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284979AbSADV5m>; Fri, 4 Jan 2002 16:57:42 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:61949 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S285007AbSADV5Z>;
	Fri, 4 Jan 2002 16:57:25 -0500
Date: Fri, 4 Jan 2002 14:57:09 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel log messages using wrong timezone
Message-ID: <20020104145709.W12868@lynx.no>
Mail-Followup-To: Chris Friesen <cfriesen@nortelnetworks.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C360D22.F6FFFAD6@nortelnetworks.com> <20020104135129.Q12868@lynx.no> <3C361AAC.EB9570B9@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3C361AAC.EB9570B9@nortelnetworks.com>; from cfriesen@nortelnetworks.com on Fri, Jan 04, 2002 at 04:12:12PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 04, 2002  16:12 -0500, Chris Friesen wrote:
> Andreas Dilger wrote:
> > On Jan 04, 2002  15:14 -0500, Chris Friesen wrote:
> > > How does the kernel figure out how to timestamp the log output?
> > > The reason I'm asking is that we have a system that has /etc/localtime
> > > pointing to the Americas/Montreal timezone, but the log output from the
> > > kernel appears to be UTC.
> > 
> > The kernel doesn't timestamp the logs, AFAIK.  That is done by syslog when
> > it writes the logs to disk.  If you check "dmesg" output - no timestamps.
> 
> Hmm...good point.  However, I should clarify that userspace logs are being
> corrected for timezone, but kernel logs are not. For userspace apps the
> timestamping is done in the glibc syslog() call, so now I need to figure out
> where it's done for the kernel.

Well, on my system I have "syslogd" and "klogd" running.  Kernel logs are
extracted from the kernel ringbuffer by klogd and passed to syslog, so that
would be the place to look.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/


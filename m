Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbWBXWbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWBXWbM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 17:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbWBXWbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 17:31:12 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:28538 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932454AbWBXWbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 17:31:12 -0500
Date: Fri, 24 Feb 2006 14:30:46 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Steven Whitehouse <swhiteho@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: GFS2 Filesystem [13/16]
Message-ID: <20060224223046.GS8083@ca-server1.us.oracle.com>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	Steven Whitehouse <swhiteho@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <1140793524.6400.734.camel@quoit.chygwyn.com> <20060222185059.GC2633@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222185059.GC2633@ucw.cz>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 06:50:59PM +0000, Pavel Machek wrote:
> > --- a/fs/Kconfig
> > +++ b/fs/Kconfig
> > @@ -883,8 +884,6 @@ config CONFIGFS_FS
> >  	  Both sysfs and configfs can and should exist together on the
> >  	  same system. One is not a replacement for the other.
> >  
> > -	  If unsure, say N.
> > -
> 
> Why? Most users probably still want configfs_fs=N.

	What version is this patch against?  This line was removed from
mainline a while ago.
	As to why it was removed, the discussion happened back then.
Basically, if something requires CONFIGFS_FS (eg, OCFS2) and is a
module, then a user is asked whether they want configfs as a module or
built-in.  Text saying "say N" is completely incorrect there.

Joel

-- 

"If the human brain were so simple we could understand it, we would
 be so simple that we could not."
	- W. A. Clouston

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWBPMH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWBPMH0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 07:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030374AbWBPMH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 07:07:26 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:16903 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932282AbWBPMHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 07:07:25 -0500
Date: Thu, 16 Feb 2006 13:07:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Steven French <sfrench@us.ibm.com>
Cc: linux-cifs-client@lists.samba.org, linux-kernel@vger.kernel.org,
       samba-technical@lists.samba.org, sfrench@samba.org
Subject: Re: [linux-cifs-client] 2.6.16-rc: CIFS reproducibly freezes the	computer
Message-ID: <20060216120723.GC3511@stusta.de>
References: <20060214135016.GC10701@stusta.de> <OFD6EC212C.9D3CD1CC-ON87257115.0057751D-86257115.0057E155@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFD6EC212C.9D3CD1CC-ON87257115.0057751D-86257115.0057E155@us.ibm.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 10:01:59AM -0600, Steven French wrote:
> 
> >...
> > It doesn't occur in 2.6.15.4, because with this kernel (and AFAIR also
> > with older kernels) my computer refuses to mount this share.
> >...

Is this issue I mentioned in my bug report expected, or could it be 
related to my problem?

>...
> Command 46 is an SMB Read.  IIRC send error in read -11 is EAGAIN which
> could
> indicate that the socket is congested and stayed congested but normally
> that would be accompanied by a "sends on socket stuck for x seconds"
> 
> Could you check /proc/fs/cifs/DebugData and see if the number of
> reconnections
> is non-zero (indicating that the tcp session to the server died).

I don't see this, do I need CONFIG_CIFS_STATS for seeing it?

> Any chance you could do an ethereal network trace of the failure (perhaps
> on the server, if the client is hanging) so we could see the
> last request (presumably a read) that the client sent (and whether the
> server responded).
> 
> Also is it possible to build your kernel with some of the debugging options
> turned on (e.g. "Debug Memory allocations" and "mutex debugging, deadlock
> detection" and
> "detect soft lockups") to see if we are overwritting memory and hitting an
> obscure
> deadlock.

Both are now on my TODO list.

> It would also be helpful, if the problem turns out to be non-obvious, to
> track this via a new bug # in bugzilla.samba.org

OK.

> Steve French

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


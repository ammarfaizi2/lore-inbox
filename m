Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266987AbTB0UlG>; Thu, 27 Feb 2003 15:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266994AbTB0UlG>; Thu, 27 Feb 2003 15:41:06 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:53509 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S266987AbTB0UlF>; Thu, 27 Feb 2003 15:41:05 -0500
Date: Thu, 27 Feb 2003 15:50:44 -0500
From: Ben Collins <bcollins@debian.org>
To: "David S. Miller" <davem@redhat.com>
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
       ak@suse.de, arnd@bergmann-dalldorf.de
Subject: Re: ioctl32 consolidation -- call for testing
Message-ID: <20030227205044.GQ21100@phunnypharm.org>
References: <20030227202739.GO21100@phunnypharm.org> <20030227.121302.86023203.davem@redhat.com> <20030227203440.GP21100@phunnypharm.org> <20030227.122126.30208201.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030227.122126.30208201.davem@redhat.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2003 at 12:21:26PM -0800, David S. Miller wrote:
>    From: Ben Collins <bcollins@debian.org>
>    Date: Thu, 27 Feb 2003 15:34:40 -0500
> 
>    On Thu, Feb 27, 2003 at 12:13:02PM -0800, David S. Miller wrote:
>    >    From: Ben Collins <bcollins@debian.org>
>    >    Date: Thu, 27 Feb 2003 15:27:39 -0500
>    >    
>    >    Here it is. Sparc64's macros for ioctl32's assumed that cmd was u_int
>    >    instead of u_long. This look ok to you, Dave?
>    > 
>    > We would love to see that patch :-)
>    
>    It was real small...so small that it slipped through mutt's open() call
>    and never got attached :)
> 
> Well, you just doubled the size of the table on sparc64.
> I don't know if I like that.

Not much of a way around it. Might seem like a big hit now (I think it's
like 4k extra), but once these ioctl's start moving into their own
driver, and out of arch/*/ioctl32.c, you'll start to get savings anyway.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/

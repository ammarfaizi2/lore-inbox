Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272090AbRH2Vkb>; Wed, 29 Aug 2001 17:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272091AbRH2VkW>; Wed, 29 Aug 2001 17:40:22 -0400
Received: from [208.48.139.185] ([208.48.139.185]:35971 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S272090AbRH2VkD>; Wed, 29 Aug 2001 17:40:03 -0400
Date: Wed, 29 Aug 2001 14:40:16 -0700
From: David Rees <dbr@greenhydrant.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        ext3-users@redhat.com
Subject: Re: kupdated, bdflush and kjournald stuck in D state on RAID1 device (deadlock?)
Message-ID: <20010829144016.C20968@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	Andrew Morton <akpm@zip.com.au>, linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org, ext3-users@redhat.com
In-Reply-To: <20010829131720.A20537@greenhydrant.com> <3B8D54F3.46DC2ABB@zip.com.au>, <3B8D54F3.46DC2ABB@zip.com.au>; <20010829141451.A20968@greenhydrant.com> <3B8D60CF.A1400171@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B8D60CF.A1400171@zip.com.au>; from akpm@zip.com.au on Wed, Aug 29, 2001 at 02:38:23PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2001 at 02:38:23PM -0700, Andrew Morton wrote:
>
> OK, thanks.  bdflush is stuck in raid1_alloc_r1bh() and
> everything else is blocked by it.  I thought we fixed 
> that a couple of months ago :(
> 
> Could you send the output of `cat /proc/meminfo'?
> 
> > 18239 -bash            wait4
> > 18274 umount /opt      rwsem_down_write_failed
> 
> What are we trying to do here?  Is /opt the deadlocked
> filesytem?

Yep, /dev/md0 is mounted on /opt.

-Dave

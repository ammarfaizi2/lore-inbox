Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285261AbRLSNA3>; Wed, 19 Dec 2001 08:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285262AbRLSNAT>; Wed, 19 Dec 2001 08:00:19 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:6930 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S285261AbRLSNAL>;
	Wed, 19 Dec 2001 08:00:11 -0500
Date: Wed, 19 Dec 2001 23:59:19 +1100
From: Anton Blanchard <anton@samba.org>
To: Marko Kentt?l? <marko.kenttala@teraflops.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel memory usage optimisations?
Message-ID: <20011219125919.GD24009@krispykreme>
In-Reply-To: <5.1.0.14.2.20011219144636.03498a10@mail.teraflops.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20011219144636.03498a10@mail.teraflops.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> I understand that best area for saving memory usage is the C-library but 
> are there any other kernel areas? I'm thinking of dropping swapfile support 
> and maybe some other subsystems that are not needed in embedded device.

Check out all the cacheline_aligned usage, in all the cases I could see
there was no reason to do this on a UP machine. You could probably get
away with redefining them to do nothing.

Also you could drop the sizes of the hashes (dentry, inode, mount,
buffer, page, route) if they are taking up RAM.

Anton

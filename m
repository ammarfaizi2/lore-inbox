Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278694AbRKHWkL>; Thu, 8 Nov 2001 17:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278690AbRKHWkC>; Thu, 8 Nov 2001 17:40:02 -0500
Received: from ns.caldera.de ([212.34.180.1]:38081 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S278768AbRKHWjz>;
	Thu, 8 Nov 2001 17:39:55 -0500
Date: Thu, 8 Nov 2001 23:39:12 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Mingming cao <cmm@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [PATCH]Disk IO statisitics gathering for all disks
Message-ID: <20011108233912.A5845@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Mingming cao <cmm@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	lse-tech@lists.sourceforge.net
In-Reply-To: <3BEB0848.735652EF@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BEB0848.735652EF@us.ibm.com>; from cmm@us.ibm.com on Thu, Nov 08, 2001 at 02:33:44PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2001 at 02:33:44PM -0800, Mingming cao wrote:
> Hello,
> 
> Attached is a patch to dynamically allocate the data buffers for the
> disk statistics, and to extend the gathering of disk statistics to
> include major numbers greater than 15.
> 
> A disk statistics structure is allocated when a new block device 
> is registered.  A global array (kstat.dkdrive_info[]) is used
> to hold the address of the statistics structures for all block
> devices.  The  disk statistics lookup is the same as before: indexed by
> the major number and the disk number.

A very minor nitpick: please use struct dk_stat (or disk_stat) instead of
dk_stat_t - it is by no means an opaque type.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263343AbTJQIQi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 04:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263347AbTJQIQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 04:16:38 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:33796 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263343AbTJQIQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 04:16:36 -0400
Date: Fri, 17 Oct 2003 09:16:34 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ludovic Drolez <ludovic.drolez@linbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0t7: /proc/partitions names not devfs like...
Message-ID: <20031017091634.B22492@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ludovic Drolez <ludovic.drolez@linbox.com>,
	linux-kernel@vger.kernel.org
References: <3F8EC144.7000005@linbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F8EC144.7000005@linbox.com>; from ludovic.drolez@linbox.com on Thu, Oct 16, 2003 at 06:03:16PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16, 2003 at 06:03:16PM +0200, Ludovic Drolez wrote:
> Hi !
> 
> I'm using devfs on a small 2.6.0t7 kernel and I have software which relies on
> the exactitude of /proc/partitions.
> The problem is that in /proc/partition I have something like
> 
>    3     0   19925880 hda
>    3     1   19920568 hda1
> 
> where a 2.4.x kernel gave me:
> 
>    3     0   19925880 ide/host0/bus0/target0/lun0/disc
>    3     1   19920568 ide/host0/bus0/target0/lun0/part1
> 
> I've enabled the following options:
> 
> CONFIG_DEVFS_FS=y
> CONFIG_DEVFS_MOUNT=y
> 
> Any idea, why this has changed ?

Yes, the 2.4 devfs behaviour was buggy - it was different from the
non-devfs output.  Note that you can't rely on the names in /proc/partitions
anyway as the system administrator is free to name the block devices however
he wants.


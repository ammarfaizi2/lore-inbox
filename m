Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261430AbSJYTAH>; Fri, 25 Oct 2002 15:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261557AbSJYTAH>; Fri, 25 Oct 2002 15:00:07 -0400
Received: from bozo.vmware.com ([65.113.40.131]:21510 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id <S261430AbSJYTAG>; Fri, 25 Oct 2002 15:00:06 -0400
Date: Fri, 25 Oct 2002 12:07:03 -0700
From: chrisl@vmware.com
To: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: How to get number of physical CPU in linux from user space?
Message-ID: <20021025190703.GC1397@vmware.com>
References: <20021024230229.GA1841@vmware.com> <20021025123857.GA1091@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021025123857.GA1091@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2002 at 01:38:57PM +0100, Dave Jones wrote:
> 
> You can perform cpuid instructions in userspace to get the
> number of siblings per physical package.
> 
Sure. But the problem is that we don't know for sure how many
of the sibling was enable in the kernel. Kernel support up to
2 siblings right now, but it might be more in later kernel. And
user might turn off sibling in kernel.

So divide the number of cpu in cpuinfo by number of siblings per
physical package do not work reliable.

Any comment to add one entry into /proc/cpuinfo to tell which physical
cpu it belong to? I don't mind submit a patch. It will be something
look like:

processor       : 2
physical cpu	: 1


Cheers

Chris



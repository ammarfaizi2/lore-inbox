Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290088AbSAWVDb>; Wed, 23 Jan 2002 16:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290083AbSAWVDS>; Wed, 23 Jan 2002 16:03:18 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:53508 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S290081AbSAWVDC>;
	Wed, 23 Jan 2002 16:03:02 -0500
Date: Wed, 23 Jan 2002 12:58:04 -0800
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Daemonize() should re-parent its caller
Message-ID: <20020123205804.GA15259@kroah.com>
In-Reply-To: <Pine.LNX.4.33L2.0201231050440.687-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0201231050440.687-100000@ida.rowland.org>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 26 Dec 2001 18:49:38 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2002 at 10:54:44AM -0500, Alan Stern wrote:
> 
> If the parent is init or another user process, we can reasonably
> expect that the zombie will be reaped eventually.  But what if the
> parent is another kernel thread?  This situation arises in the USB
> mass-storage device driver, where the device manager and scsi
> error-handler threads are spawned (indirectly) by the khubd kernel
> thread.

What problem are you seeing with the khubd and USB mass-storage kernel
threads?  There is a patch in the most recent kernel versions that
slightly modifies the usb-storage kernel thread logic, supposedly to fix
a problem that people were having under very long scsi timeouts.

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293235AbSCFFmC>; Wed, 6 Mar 2002 00:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293237AbSCFFlw>; Wed, 6 Mar 2002 00:41:52 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:22541 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S293234AbSCFFlk>;
	Wed, 6 Mar 2002 00:41:40 -0500
Date: Tue, 5 Mar 2002 21:33:55 -0800
From: Greg KH <greg@kroah.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Sandino Araico =?iso-8859-1?Q?S=E1nchez?= <sandino@sandino.net>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.17,2.4.18 ide-scsi+usb-storage+devfs Oops
Message-ID: <20020306053355.GA13072@kroah.com>
In-Reply-To: <3C7EA7CB.C36D0211@sandino.net> <20020302075847.GE20536@kroah.com> <3C84294C.AE1E8CE9@sandino.net> <200203060528.g265Sh502430@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200203060528.g265Sh502430@vindaloo.ras.ucalgary.ca>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 06 Feb 2002 02:32:39 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2002 at 10:28:43PM -0700, Richard Gooch wrote:
> 
> I suspect the USB-UHCI driver is doing a double-unregister on a devfs
> entry. Please set CONFIG_DEVFS_DEBUG=y, recompile and boot the new
> kernel. Send the new Oops (passed through ksymoops, of course).

None of the USB host controller drivers (like usb-uhci.c) call any devfs
functions.

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285153AbSAGTAj>; Mon, 7 Jan 2002 14:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285186AbSAGTAX>; Mon, 7 Jan 2002 14:00:23 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:10251 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S285165AbSAGTAJ>;
	Mon, 7 Jan 2002 14:00:09 -0500
Date: Mon, 7 Jan 2002 10:58:13 -0800
From: Greg KH <greg@kroah.com>
To: esr@thyrsus.com, kbuild-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: Hardware Inventory [was: Re: ISA slot detection on PCI systems?]
Message-ID: <20020107185813.GL7378@kroah.com>
In-Reply-To: <Pine.LNX.4.33.0201070955480.867-100000@segfault.osdlab.org> <Pine.LNX.4.33.0201071908580.16327-100000@Appserv.suse.de> <20020107185001.GK7378@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020107185001.GK7378@kroah.com>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 10 Dec 2001 15:13:28 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002 at 10:50:01AM -0800, Greg KH wrote:
> 
> And the /sbin/hotplug program knows about _all_ devices that the
> currently compiled kernel can handle due to the MODULE_DEVICE_TABLE tags
> in the drivers.

Along these lines, I am very disappointed in looking at the
autoconfigure stuff in CML2.  It should be taking all of the device and
driver matching information from the kernel itself, as it is already
specified there.

Look at the modules.*map files.  They specify the kernel drivers that
specific devices work for.  They are automatically created from the
kernel that you just built.

Eric, if you are going to keep your "2000+" configuration probes up to
date by hand, good luck.  Look at all of the new USB drivers that have
been added in just the 2.5.2-pre series alone.  That's a lot of data to
keep track of.

The rest of us have decided to rely on automatic tools for this process :)

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262652AbTCIVRz>; Sun, 9 Mar 2003 16:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262653AbTCIVRy>; Sun, 9 Mar 2003 16:17:54 -0500
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:42443 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id <S262652AbTCIVRx>;
	Sun, 9 Mar 2003 16:17:53 -0500
Date: Sun, 9 Mar 2003 22:28:15 +0100
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gen_init_cpio fixes for 2.5.64
Message-ID: <20030309212815.GC14858@h55p111.delphi.afb.lu.se>
References: <20030305060817.GC26458@kroah.com> <20030308004249.GA23071@kroah.com> <20030308004340.GB23071@kroah.com> <20030308143745.GB7234@h55p111.delphi.afb.lu.se> <20030309060452.GA28835@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030309060452.GA28835@kroah.com>
X-message-flag: Outlook is bad for you, use mutt
User-Agent: Mutt/1.5.3i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *18s8L9-0005vc-00*bDXJJFt2.TQ* (0x63.nu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 10:04:52PM -0800, Greg KH wrote:
> On Sat, Mar 08, 2003 at 03:37:45PM +0100, Anders Gustafsson wrote:
> > On Fri, Mar 07, 2003 at 04:43:40PM -0800, Greg KH wrote:
> > > 
> > > ChangeSet 1.1124, 2003/03/07 16:39:06-08:00, greg@kroah.com
> > > 
> > > gen_init_cpio: Add the ability to add files to the cpio image.
> > 
> > Have you been able to boot the kernel with a cpio-archive that contains
> > files larger than a few k? The kernel crashes on me when writing to the file
> > in ramfs.
> 
> I have not tried that, no.
> 
> > It crashes i the third or forth flush_window or so..
> 
> What does the oops show?

I don't have the possibility to capture it at the moment, I have no
serialports on my laptop and no other computer I can test it on at hand at
the moment. 

But it's really easy to reproduce, just add a:
        cpio_mkfile("/bin/busybox","/bin/sh",0755,0,0);
	
or something similar in usr/gen_init_cpio.c

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/

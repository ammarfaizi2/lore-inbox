Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265820AbUACBAS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 20:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265908AbUACBAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 20:00:18 -0500
Received: from smtp06.iddeo.es ([62.81.186.16]:4508 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S265820AbUACBAM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 20:00:12 -0500
Date: Sat, 3 Jan 2004 02:00:10 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: udev - please help me to understand
Message-ID: <20040103010010.GA14823@werewolf.able.es>
References: <microsoft-free.87r7yiinaj.fsf@eicq.dnsalias.org> <20040102202316.GD4992@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040102202316.GD4992@kroah.com> (from greg@kroah.com on Fri, Jan 02, 2004 at 21:23:16 +0100)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 01.02, Greg KH wrote:
> On Fri, Jan 02, 2004 at 09:48:36PM +1000, Steve Youngs wrote:
> > Hi Greg!
> > 
> > I've been looking at this "udev" thingy and I can't for the life of me
> > see why I'd need it.  There doesn't appear to be _any_ advantages of
> > using udev in my present situation.
> 
> Ok, great.  Then don't use it, I'm not forcing you to for 2.6 :)
> 
> > No, I don't use devfs.
> > 
> > I have zero hot-pluggable devices (that might change somewhere in the
> > distant future, but for now I don't have any).  And never in my wildest
> > dreams could I ever imagine running out of device numbers.
> > 
> > Reading through the documentation that I've found about udev, your
> > main points seem to be about:
> > 
> >         - udev vs devfs
> >         - running out of device major/minor numbers
> >         - not having to worry about major/minor numbers
> > 
> > For me, the first point is moot because I don't use devfs.  The second
> > point is just plain ridiculous, there is just _no_ way that it could
> > happen (remember that I'm talking about my own situation).  
> 
> If you never have any hotpluggable devices, nor any need to move disks
> around in your system, then you don't need udev.
> 

Don't think so. My first use for udev is a cluster (when bproc works on
2.6 ;)). Or in general diskless booting.

You build your initrd for remote boot. You have two options:
- copy a full /dev from a working host (tons of files that make the rd big
  just to fit all the inodes).
- spend a lot of time guessing what is and what is not needed on each node
  (you can have ata drives, scsi ones, different network cards, different
  graphics cards...)

I just want to boot with and empty /dev and let udev populate it, even with
same device names for different hadrware. And nodes will never hotplug anything.

IE, I want a working and race free devfs, and this is udev.

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.6.1-rc1-jam1 (gcc 3.3.2 (Mandrake Linux 10.0 3.3.2-3mdk))

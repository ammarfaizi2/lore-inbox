Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268133AbTAKTbG>; Sat, 11 Jan 2003 14:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268135AbTAKTbG>; Sat, 11 Jan 2003 14:31:06 -0500
Received: from ldap.somanetworks.com ([216.126.67.42]:22699 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id <S268133AbTAKTbE>; Sat, 11 Jan 2003 14:31:04 -0500
Date: Sat, 11 Jan 2003 14:39:47 -0500 (EST)
From: Scott Murray <scottm@somanetworks.com>
X-X-Sender: scottm@rancor.yyz.somanetworks.com
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Grant Grundler <grundler@cup.hp.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Paul Mackerras <paulus@samba.org>,
       <davidm@hpl.hp.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <greg@kroah.com>
Subject: Re: [patch 2.5] 2-pass PCI probing, generic part
In-Reply-To: <20030111004239.A757@localhost.park.msu.ru>
Message-ID: <Pine.LNX.4.44.0301111346200.9854-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jan 2003, Ivan Kokshaysky wrote:

> On Fri, Jan 10, 2003 at 11:00:30AM -0800, Grant Grundler wrote:
> > Or dynamically assigns windows to PCI Bus controllers as PCI devices
> > are brought on-line.
> 
> Eh? In general case, to make room for newly added device, you have
> to shutdown the whole PCI bus starting from level 0, reassign _all_
> BARs and bridge windows and then restart...
> The "hotplug resource reservation" is the only viable approach, it has
> been discussed numerous times.
> 
> > For PCI Hotplug, the role of managing MMIO/IRQ
> > resources has moved to the OS since these services are needed
> > after the OS has taken control of the box.
> 
> 100% agree. :-)

Since the lack of resource reservation currently is keeping CompactPCI
hot insertion from working properly, I have a strong interest in getting
something in place before 2.6.  I've got a completely manual (kernel
command-line parameter controlled) reservation patch[1] against 2.4 that
I could start updating, but I've always thought there must be a more 
elegant way to do things than the somewhat crude fixup approach I used
in it.  I'm willing to try coding up something if you or anyone else
have some ideas as to what would be an acceptable solution.

Thanks,

Scott

[1] look at the new file drivers/pci/setup-hp.c contained in:
ftp://oss.somanetworks.com/pub/linux/cpci/v2.4/linux-2.4.19-cpci-20021107.diff.gz


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com



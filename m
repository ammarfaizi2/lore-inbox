Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318762AbSHLR2Z>; Mon, 12 Aug 2002 13:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318760AbSHLR13>; Mon, 12 Aug 2002 13:27:29 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:63246 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318758AbSHLR1K>;
	Mon, 12 Aug 2002 13:27:10 -0400
Date: Mon, 12 Aug 2002 10:27:14 -0700
From: Greg KH <greg@kroah.com>
To: Scott Murray <scottm@somanetworks.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pcihpfs problems in 2.4.19
Message-ID: <20020812172713.GE15249@kroah.com>
References: <Pine.LNX.4.33.0208091547280.32159-100000@rancor.yyz.somanetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0208091547280.32159-100000@rancor.yyz.somanetworks.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 15 Jul 2002 14:49:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2002 at 04:18:02PM -0400, Scott Murray wrote:
> I just started testing the cPCI hotplug driver I'm working on against
> 2.4.19 after upgrading the kernel in SOMA's in-house distribution,
> and I'm now getting the attached oops code when trying to access the
> pcihpfs (e.g. with ls) after mounting it.  I backed out the couple of
> changes I made last night that might have been remotely connected
> (added hardware_test and get_power_status hotplug ops in my driver),
> and I'm still getting it in the same place, so it looks like maybe a
> VFS change somewhere in 2.4.19 broke pcihpfs.  Any ideas?

Hm, I just verified this on one of my machines, but a different one
(ia64 box) works just fine.  I'll dig and try to find the problem later
on today.  As a side note, someone who based their code off of pcihpfs
also has the same problem, so I think it's some vfs change that I didn't
catch.

thanks,

greg k-h

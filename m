Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319600AbSH3QOy>; Fri, 30 Aug 2002 12:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319604AbSH3QOy>; Fri, 30 Aug 2002 12:14:54 -0400
Received: from [63.204.6.12] ([63.204.6.12]:7577 "EHLO mail.somanetworks.com")
	by vger.kernel.org with ESMTP id <S319600AbSH3QOx>;
	Fri, 30 Aug 2002 12:14:53 -0400
Date: Fri, 30 Aug 2002 12:19:14 -0400 (EDT)
From: "Scott Murray" <scottm@somanetworks.com>
X-X-Sender: <scottm@rancor.yyz.somanetworks.com>
To: Greg KH <greg@kroah.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pcihpfs problems in 2.4.19
In-Reply-To: <20020813195539.GA22408@kroah.com>
Message-ID: <Pine.LNX.4.33.0208301215560.18516-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2002, Greg KH wrote:

> On Fri, Aug 09, 2002 at 04:18:02PM -0400, Scott Murray wrote:
> > I just started testing the cPCI hotplug driver I'm working on against
> > 2.4.19 after upgrading the kernel in SOMA's in-house distribution,
> > and I'm now getting the attached oops code when trying to access the
> > pcihpfs (e.g. with ls) after mounting it.  I backed out the couple of
> > changes I made last night that might have been remotely connected
> > (added hardware_test and get_power_status hotplug ops in my driver),
> > and I'm still getting it in the same place, so it looks like maybe a
> > VFS change somewhere in 2.4.19 broke pcihpfs.  Any ideas?
>
> Ah, looks like a change with readdir.c in 2.4.19-pre2 caused this
> problem.  Please try the attached patch, it fixes the problem for me.

I've finally gotten around to trying this out after coming back from
vacation, and have verified that it fixes the problem for me.

> Thanks to Dan Stekloff for helping in finding this fix.

Ditto, I wan't enjoying the prospect of trying to debug this myself.

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com


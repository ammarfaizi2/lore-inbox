Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbWJMAF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWJMAF6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 20:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWJMAF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 20:05:58 -0400
Received: from web83108.mail.mud.yahoo.com ([216.252.101.37]:1646 "HELO
	web83108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751356AbWJMAF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 20:05:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=R9htUGvT17xsSTfgP0Ki/q8EJN5OCBHZaHU9l1M3n3bCNpGNC3COdWdSadlXQgKApGH/QZlf6Ob7mIKMZhzqouHiWLrG+5/akODNVdJrHtwZf5CW60/rea6htdopXay0igdXdm/xctdOhaOkDv8i4BHJkyZJj7CynpCqifMNk1Q=  ;
Message-ID: <20061013000556.89570.qmail@web83108.mail.mud.yahoo.com>
Date: Thu, 12 Oct 2006 17:05:56 -0700 (PDT)
From: Aleksey Gorelov <dared1st@yahoo.com>
Subject: Re: Machine reboot
To: Auke Kok <sofar@foo-projects.org>
Cc: xhejtman@mail.muni.cz, linux-kernel@vger.kernel.org, magnus.damm@gmail.com,
       pavel@suse.cz
In-Reply-To: <452ED33A.6000106@foo-projects.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Auke Kok <sofar@foo-projects.org> wrote:
> Aleksey Gorelov wrote:
> >> -----Original Message-----
> >> From: linux-kernel-owner@vger.kernel.org 
> >> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Lukas 
> >> Hejtmanek
> >> Sent: Thursday, October 05, 2006 3:53 AM
> >> To: linux-kernel@vger.kernel.org
> >> Subject: Machine reboot
> >>
> >> Hello,
> >>
> >> I'm facing troubles with machine restart. While sysrq-b 
> >> restarts machine, reboot
> >> command does not. Using printk I found that kernel does not 
> >> hang and issues
> >> reset properly but BIOS does not initiate boot sequence. Is 
> >> there something
> >> I could do?
> > 
> >   I have similar issue on Intel DG965WH board. Did you try to shutdown network interface and
> > 'rmmod e1000' right before reboot ? In my case machine reboots fine after that.
> > 
> > Aleks.
> 
> interesting, do you do that because it specifically fixes a problem you have? if so, I'd 
> like to know about it :)
> 
> Auke
> 
I'm just trying to localize the issue. 
Since right before machine stalls during reboot I see something like

ACPI: PCI interrupt for device 000:00:19.0 disabled
Restarting system.

and this device is Gb ethernet, e1000 is perfect candidate to look at. And yes, removing e1000
before reboot works around the issue.

I'm afraid this is now common issue across Intel 965 board series, at least with their latest BIOS
updates.

Aleks.



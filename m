Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263052AbTCWNXz>; Sun, 23 Mar 2003 08:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263053AbTCWNXz>; Sun, 23 Mar 2003 08:23:55 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:21989 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263052AbTCWNXy>; Sun, 23 Mar 2003 08:23:54 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200303231334.h2NDYvx00679@devserv.devel.redhat.com>
Subject: Re: Linux 2.5.65-ac3
To: greg@kroah.com (Greg KH)
Date: Sun, 23 Mar 2003 08:34:57 -0500 (EST)
Cc: alan@redhat.com (Alan Cox), jgarzik@pobox.com (Jeff Garzik),
       linux-kernel@vger.kernel.org
In-Reply-To: <20030323071124.GA23036@kroah.com> from "Greg KH" at Mar 22, 2003 11:11:25 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, Mar 22, 2003 at 07:44:09PM -0500, Alan Cox wrote:
> > Fixing the pci api hotplug races
> 
> Is this just the pci device list issue (lack of locking), or something
> else?

Device list is the one I know about. There are some races with reuse of
ports but those I think are now entirely driver level offences. Some
drivers return from unplug without using del_timer_sync and killing
workqueues so will shit on whatever gets the ports next if its a quick
change


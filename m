Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754161AbWKGJxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754161AbWKGJxv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 04:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754164AbWKGJxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 04:53:50 -0500
Received: from tag.witbe.net ([81.88.96.48]:5566 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S1754161AbWKGJxu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 04:53:50 -0500
Reply-To: <rol@as2917.net>
From: "Paul Rolland" <rol@as2917.net>
To: "'Jan Engelhardt'" <jengelh@linux01.gwdg.de>
Cc: "'Marc Perkel'" <marc@perkel.com>,
       "'Chris Lalancette'" <clalance@redhat.com>,
       "'Rafael J. Wysocki'" <rjw@sisk.pl>, <linux-kernel@vger.kernel.org>
Subject: RE: could not find filesystem /dev/root
Date: Tue, 7 Nov 2006 10:52:55 +0100
Organization: AS2917.net
Message-ID: <004001c70252$82702570$4b00a8c0@donald>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <Pine.LNX.4.61.0611071013420.11192@yvahk01.tjqt.qr>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Thread-Index: AccCTeH044QjMYmcTgqRrJ9Fip1lBgABBaGw
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> The order in which disks are discovered, is basically
> (1) what module (let's take the "core kernel" as a module 
> too) is loaded first (core kernel always comes first)
> (2) running order of the __init functions in a specific module;
>     running order mostly defined by linking order

Yes... What is painful is that moving from a configuration with modules
to a configuration without modules, this can change. 

> >and resulted in drives changing devices :
> >FC5               Vanilla
> >/dev/sda   <--->  /dev/sdb
> >/dev/sdb   <--->  /dev/sdc
> >/dev/sdc   <--->  /dev/sda

> If you don't want udev, make an initramfs, build your disk driver as 
> modules, and load them in the order you want your disks numbered.
> 
> udev or initramfs, you ought to choose at least one.

Nope, you don't. I'm now using a kernel without modules for what's disk 
related, and unless people (read kernel developpers) change something 
in the init order, I'm now with a stable environment, without udev or
initramfs.

Paul


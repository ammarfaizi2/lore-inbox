Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265122AbTFMEQN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 00:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265125AbTFMEQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 00:16:13 -0400
Received: from smtp-out.comcast.net ([24.153.64.116]:37414 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S265122AbTFMEQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 00:16:12 -0400
Date: Fri, 13 Jun 2003 00:23:18 -0400
From: Albert Cahalan <albert@users.sf.net>
Subject: Re: PCI stuff
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: benh@kernel.crashing.org, anton@samba.org, rmk@arm.linux.org.uk,
       mochel@osdl.org, willy@debian.org
Message-id: <1055478198.4048.146.camel@cube>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.4
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The new pci_domain_nr() is good for adding the PCI domain
> number to the /sys/devices/pciN/* names, but I think that's
> not the proper representation. It should really be
>
>  /sys/devices/pci-domainN/pciN/*
>
> So we can pave the way for when we'll stop play bus number
> tricks and actually have overlapping PCI bus numbers between
> domains. (I don't plan to do that immediately because that
> would break userland & /proc/bus/pci backward compatiblity)
>
> What do you think ?

This should have been obvious to me last week:
/sys/devices/pciN/busM/devQ/fnP/*

N is the thingy number. (domain, segment, hose...)

It's important to get the interface right, even if
that means a bit of short-term trouble. We'll be
stuck with the interface, like it or not, for a
damn long time once 2.6.xx gets established.



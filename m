Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbULUKNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbULUKNg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 05:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbULUKNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 05:13:36 -0500
Received: from gate.firmix.at ([80.109.18.208]:44509 "EHLO gate.firmix.at")
	by vger.kernel.org with ESMTP id S261682AbULUKNb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 05:13:31 -0500
Subject: Re: loading modules at kernel startup
From: Bernd Petrovitsch <bernd@firmix.at>
To: Alex Riesen <raa.lkml@gmail.com>
Cc: linux lover <linux.lover2004@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <81b0412b041221013752802fc5@mail.gmail.com>
References: <72c6e3790412210114650e05d1@mail.gmail.com>
	 <81b0412b041221013752802fc5@mail.gmail.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Message-Id: <1103624005.31674.10.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.5 
Date: Tue, 21 Dec 2004 11:13:25 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-21 at 10:37 +0100, Alex Riesen wrote:
> On Tue, 21 Dec 2004 14:44:23 +0530, linux lover
> <linux.lover2004@gmail.com> wrote:
[...]
> > How to load own kernel modules just after eth0
> > interface is brought up?
> > I want to load kernel module as soon as networking part of kenrel
> > starts.

This usually depends on your distribution.

> Look at udev and hotplug
> 
> > I dont want to loose any packets that travels on my linux
> > machine.
> 
> You'll always loose something: there will be a gap between activating
> of the network interface and running of your module (or sniffer, as it sounds).

Not if you do all on "activating the network interface" except "ip link
set eth<x> up".
Usually this means patching your distributions network startup scripts
and/or hooking in the firewall-rule-startup-script (where you basically
have the same problem).

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services


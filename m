Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265666AbTFSQaU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 12:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265416AbTFSQaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 12:30:19 -0400
Received: from air-2.osdl.org ([65.172.181.6]:43940 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265731AbTFSQaM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 12:30:12 -0400
Date: Thu, 19 Jun 2003 09:46:19 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: "Kevin P. Fleming" <kpfleming@cox.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Flaw in the driver-model implementation of attributes
In-Reply-To: <3EF101E4.3030900@cox.net>
Message-ID: <Pine.LNX.4.44.0306190943110.955-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > What is a sysfs "class", as in /sys/class/...?
> 
> It is an abstraction. It is a group of objects that implement common 
> functionality, and have common attributes and behaviors.

Not quite. A class represents a class of devices, or the function that a 
device performs, e.g. disk or sound. 

> > What do sysfs classes have in common? How is
> > a /sys/class/ different from a /sys/devices,
> > /sys/bus, etc?
> 
> /sys/bus, /sys/block are just special-case classes that get their own 
> top-level directory. They could just easily have been put under 
> /sys/class/block, /sys/class/bus.

No. If you want to go that far, 'devices' could go under there as well, 
and we'd eventually just have one top-level directory: /sys/class :) 

The top-level directories in sysfs represent classes of objects, not 
necessarily tied to any driver model concepts. The reason it's so 
driver-model heavy now is because that's how the whole thing originated. 


	-pat


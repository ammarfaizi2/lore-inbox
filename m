Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267270AbTAAQSJ>; Wed, 1 Jan 2003 11:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267271AbTAAQSJ>; Wed, 1 Jan 2003 11:18:09 -0500
Received: from [81.2.122.30] ([81.2.122.30]:38663 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267270AbTAAQSI>;
	Wed, 1 Jan 2003 11:18:08 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301011623.h01GN8Lw001696@darkstar.example.net>
Subject: Re: [PATCH] fix os release detection in module-init-tools-0.9.6
To: davidsen@tmr.com (Bill Davidsen)
Date: Wed, 1 Jan 2003 16:23:08 +0000 (GMT)
Cc: rddunlap@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1030101104259.14470A-100000@gatekeeper.tmr.com> from "Bill Davidsen" at Jan 01, 2003 10:51:14 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > | Um, you read the .config, which hopefully is stored somewhere.
> > | (Although you could resurrect the /proc/config patch which goes around
> > | every so often).  There are many things you can't tell by reading
> > | /proc/ksyms.
> > 
> > Right, the .config file is the answer.  And there are at least 2
> > patch solutions for it, the /proc/config that Rusty mentioned, or
> > the in-kernel config that Khalid Aziz and others from HP did along
> > with me, and it's in 2.4.recent-ac or 2.5.recent-dcl or 2.5.recent-cgl.
> 
> It would be useful to have a few global options perhaps included in /proc
> (or wherever) on all kernels. By global I mean those which affect the
> entire kernel, like preempt or smp, rather than driver options. We already
> note 'tainted,' so this is not a totally new idea. It would seem that most
> of the processor options could fall in this class, MCE, IOAPIC, etc.
> 
> If the aim is to speed stability, putting any of the "whole config"
> options in and defaulted on might be a step toward that.

Having all of the config options in a /proc/config file would be a
great help for people using my new bug database, because it would
allow them to upload the .config for their current kernel even if it
is not one they have compiled themselves.

At the moment, the facility to search for bugs via the config options
that cause them is only useful for people who are compiling their own
kernel.

John.

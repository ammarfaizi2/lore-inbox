Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWIKJq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWIKJq0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 05:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWIKJq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 05:46:26 -0400
Received: from ns2.suse.de ([195.135.220.15]:15085 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932179AbWIKJqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 05:46:25 -0400
Date: Mon, 11 Sep 2006 11:46:07 +0200
From: Stefan Seyfried <seife@suse.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: ACPI mailing list <linux-acpi@vger.kernel.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: x60 - spontaneous thermal shutdown
Message-ID: <20060911094607.GA14095@suse.de>
References: <20060904214059.GA1702@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060904214059.GA1702@elf.ucw.cz>
X-Operating-System: openSUSE 10.2 (i586) Alpha4, Kernel 2.6.18-rc5-git6-2-default
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2006 at 11:40:59PM +0200, Pavel Machek wrote:
> Hi!
> 
> x60 shut down after quite a while of uptime, in period of quite heavy
> load:
> 
> Sep  4 23:33:01 amd kernel: ACPI: Critical trip point
> Sep  4 23:33:01 amd kernel: Critical temperature reached (128 C), shutting down.
> Sep  4 23:33:01 amd shutdown[32585]: shutting down for system halt
> Sep  4 23:34:42 amd init: Switching to runlevel: 0
> 
> I do not think cpu reached 128C, as I still have my machine... Did
> anyone else see that?

my usual suspect: use ec_intr=0. I have seen this rather often on HP machines.
I attributed it to "communication problems with embedded controller" and
ec_intr=0 seemed to help somehow. But then, this was some kernel versions
ago and i did not encounter it recently.
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen

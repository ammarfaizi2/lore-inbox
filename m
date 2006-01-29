Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbWA2HNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWA2HNA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 02:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWA2HM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 02:12:59 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:24519 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1750872AbWA2HM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 02:12:59 -0500
Date: Sun, 29 Jan 2006 07:12:39 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Luca <kronos@kronoz.cjb.net>, linux-kernel@vger.kernel.org
Subject: Re: Suspend to RAM: help with whitelist wanted
Message-ID: <20060129071239.GB23736@srcf.ucam.org>
References: <20060126213611.GA1668@elf.ucw.cz> <20060127170406.GA6164@dreamland.darkstar.lan> <20060127232207.GB1617@elf.ucw.cz> <20060128013111.GA30225@srcf.ucam.org> <20060128084225.GC1605@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060128084225.GC1605@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2006 at 09:42:25AM +0100, Pavel Machek wrote:

> Well, doing it at boot is slightly ugly; I'd like s2ram to just work,
> and not need boot-time-hooks. [If there's no other solution... what
> can I do, but I do not like it.]

Indeed. The symptoms are that X stops drawing the background to windows, 
and it seems to be very strongly tied to saving the state while X is 
running (even if X is not currently the foreground VT). 

> Thanks for pointer! Anyway, AFAICT the list is not really adequate. It
> lists working machines, but does not really list all the switches
> neccessary to get the video working. (Well, it tries in some cases,
> *strange*, perhaps less switches are neccessary than I think?)

For machines where nothing is listed, we do POSTing and restore the VBE 
state. These may not be necessary in all cases, but they don't seem to 
be actively harmful except on the machines where they're explicitly 
switched of.f
-- 
Matthew Garrett | mjg59@srcf.ucam.org

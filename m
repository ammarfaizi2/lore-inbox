Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVFHP03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVFHP03 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 11:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVFHP02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 11:26:28 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:37131 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261321AbVFHPYj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 11:24:39 -0400
Date: Wed, 8 Jun 2005 17:24:42 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ipw2100: firmware problem
Message-ID: <20050608152442.GA7773@irc.pl>
Mail-Followup-To: kernel list <linux-kernel@vger.kernel.org>
References: <20050608142310.GA2339@elf.ucw.cz> <200506081744.20687.vda@ilport.com.ua> <20050608145653.GA8844@dwarf.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050608145653.GA8844@dwarf.suse.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2005 at 04:56:53PM +0200, Jirka Bohac wrote:
> I don't think this is true. Loading the firmware on the first
> "ifconfig up" is problematic. Often, people want to rename the
> device from ethX/wlanX/... to something stable. This is usually
> based on the adapter's MAC address, which is not visible until
> the firmware is loaded.
 
> I agree that drivers should initialize the adapter in the OFF
> state, but the firmware needs to be loaded earlier than the
> first ifconfig up.
> 
> How about loading the firmware when the first ioctl touches the
> device? This way, it would get loaded just before the MAC address
> is retrieved.

 Best way to rename network adapter is to use udev. So MAC must be
available (and present in /sysfs) when hotplug event for adapter is
generated.

-- 
Tomasz Torcz               RIP is irrevelant. Spoofing is futile.
zdzichu@irc.-nie.spam-.pl     Your routes will be aggreggated. -- Alex Yuriev


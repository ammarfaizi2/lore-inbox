Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbWHMUcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWHMUcb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 16:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWHMUca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 16:32:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37545 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751416AbWHMUca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 16:32:30 -0400
Date: Sun, 13 Aug 2006 13:32:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       apiszcz@solarrain.com
Subject: Re: Linux 2.6.17.6 Kernel Oops: kmem_cache_create: duplicate cache
 scsi_cmd_cache
Message-Id: <20060813133210.8a2fe10d.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0608131608460.20462@p34.internal.lan>
References: <Pine.LNX.4.64.0608131608460.20462@p34.internal.lan>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Aug 2006 16:12:26 -0400 (EDT)
Justin Piszcz <jpiszcz@lucidpixels.com> wrote:

> Executing the following commands:
> 
> # --------------- #
> 
> rmmod sym53c8xx scsi_transport_spi st scsi_mod
> 
> modprobe scsi_mod
> modprobe st
> modprobe scsi_transport_spi
> modprobe sym53c8xx
> 
> scsiadd -s
> 
> # --------------- #
> 
> Then I got this, see dmesg below:
> 
> ...
>
> [4489213.171000] kmem_cache_create: duplicate cache scsi_cmd_cache

google("duplicate cache scsi_cmd_cache") indicates that this bug has been
present and known about for at least two and a half years.


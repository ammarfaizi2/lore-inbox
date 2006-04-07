Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbWDGV2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWDGV2q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 17:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWDGV2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 17:28:45 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:21661 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932373AbWDGV2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 17:28:45 -0400
Date: Fri, 7 Apr 2006 23:28:43 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Piotr Muszynski <piotru@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: make *config problem (breaks miniconfig.sh)
In-Reply-To: <c03109120604060438n58657c97iea4bfa5342747f18@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0604072326150.17704@scrub.home>
References: <c03109120604060438n58657c97iea4bfa5342747f18@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 6 Apr 2006, Piotr Muszynski wrote:

> Spotted on 2.6.15.[1,2] and 2.6.16
> 
> How to trigger:
> make menuconfig, change CONFIG_EXPERIMENTAL y --> n, save
> $ cp .config .config_old
> make menuconfig, change nothing, save
> $ diff .config .config_old
> 4c4
> < # Thu Apr  6 20:23:19 2006
> ---
> > # Thu Apr  6 20:22:40 2006
> 157a158,160
> > # CONFIG_FLATMEM_MANUAL is not set
> > # CONFIG_DISCONTIGMEM_MANUAL is not set
> > # CONFIG_SPARSEMEM_MANUAL is not set
> 
> I thought the .config shouldn't change... Is this a feature?

No, it's a bug, although not a critical one. I have to look into this.

bye, Roman

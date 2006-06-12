Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWFLVDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWFLVDM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 17:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWFLVDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 17:03:11 -0400
Received: from relay03.pair.com ([209.68.5.17]:53260 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S932093AbWFLVDK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 17:03:10 -0400
X-pair-Authenticated: 71.197.50.189
Date: Mon, 12 Jun 2006 15:55:23 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Andrew Clayton <andrew@digital-domain.net>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: VMSPLIT kernel config option
In-Reply-To: <20060612215434.0b8c873f@alpha.digital-domain.net>
Message-ID: <Pine.LNX.4.64.0606121552380.17886@turbotaz.ourhouse>
References: <20060612215434.0b8c873f@alpha.digital-domain.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2006, Andrew Clayton wrote:

> Hi,
>
> Is it meant, that the VMSPLIT_* options are only enabled
> "if EMBEDDED"?

Indeed. Unfortunately, adjusting VMSPLIT appeared to break the assumptions 
of some programs like Valgrind (and hence caused a regression for some 
users). VMSPLIT was thusly "hidden" under CONFIG_EMBEDDED such that the only
people who would be inclined to mess with the setting were people already tinkering 
with "low-level" settings if you will.

> See line 470 of arch/i386/Kconfig
>
> This is with 2.6.17-rc6-git4
>
>
> Cheers
>
> Andrew

Thanks,
Chase

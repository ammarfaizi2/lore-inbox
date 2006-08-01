Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWHAQ4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWHAQ4U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 12:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWHAQ4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 12:56:20 -0400
Received: from relay03.pair.com ([209.68.5.17]:27155 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S1751176AbWHAQ4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 12:56:19 -0400
X-pair-Authenticated: 71.197.50.189
Date: Tue, 1 Aug 2006 11:56:06 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Amit Gud <agud@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] sysctl for the latecomers
In-Reply-To: <44CF69F0.6040801@redhat.com>
Message-ID: <Pine.LNX.4.64.0608011155040.12077@turbotaz.ourhouse>
References: <44CF69F0.6040801@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2006, Amit Gud wrote:

> /etc/sysctl.conf values are of no use to kernel modules that are inserted 
> after init scripts call sysctl for the values in /etc/sysctl.conf
>
> For modules to use the values stored in the file /etc/sysctl.conf, sysctl 
> kernel code can keep record of 'limited' values, for sysctl entries which 
> haven't been registered yet. During registration, sysctl code can check 
> against the stored values and call the appropriate strategy and proc_handler 
> routines if a match is found.
>
> Attached patch does just that. This patch is NOT tested and is just to get 
> opinions, if something like this is a right way of addressing this problem.

Do you anticipate any users that you could list? It seems like a more 
appropriate approach would be to allow some kind of user-space hook or 
event notification to run upon module insertion, which could then apply 
the appropriate sysctl.

>
> Thanks,
> AG
>

Thanks,
Chase

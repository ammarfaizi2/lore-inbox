Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWHARlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWHARlz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 13:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751725AbWHARlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 13:41:55 -0400
Received: from terminus.zytor.com ([192.83.249.54]:40397 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750794AbWHARly
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 13:41:54 -0400
Message-ID: <44CF9258.8020304@zytor.com>
Date: Tue, 01 Aug 2006 10:41:44 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Amit Gud <agud@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] sysctl for the latecomers
References: <44CF69F0.6040801@redhat.com>
In-Reply-To: <44CF69F0.6040801@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amit Gud wrote:
> /etc/sysctl.conf values are of no use to kernel modules that are 
> inserted after init scripts call sysctl for the values in /etc/sysctl.conf
> 
> For modules to use the values stored in the file /etc/sysctl.conf, 
> sysctl kernel code can keep record of 'limited' values, for sysctl 
> entries which haven't been registered yet. During registration, sysctl 
> code can check against the stored values and call the appropriate 
> strategy and proc_handler routines if a match is found.
> 
> Attached patch does just that. This patch is NOT tested and is just to 
> get opinions, if something like this is a right way of addressing this 
> problem.
> 

Sounds like it would make more sense to add this kind of functionality 
to modprobe.

	-hpa


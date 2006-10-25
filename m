Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030473AbWJYPYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030473AbWJYPYo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 11:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030475AbWJYPYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 11:24:44 -0400
Received: from 195-13-16-24.net.novis.pt ([195.23.16.24]:31207 "EHLO
	bipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1030473AbWJYPYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 11:24:43 -0400
Message-ID: <453F81B6.3080205@grupopie.com>
Date: Wed, 25 Oct 2006 16:24:38 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Michael <michael.sallaway@gmail.com>
CC: ray-gmail@madrabbit.org, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Oops when doing disk heavy disk I/O
References: <453f585d.299e45f8.4666.371b@mx.google.com>
In-Reply-To: <453f585d.299e45f8.4666.371b@mx.google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael wrote:
>> From: Ray Lee [mailto:madrabbit@gmail.com] 
>> Try swapping out the RAM (or getting it down to 1Gig). Try a really
>> old kernel, such as debian's 2.6.8 package.
> 
> [...]
> Although, having said that, I'm curious... It is working because there's
> only 1 gig of RAM in there, or because it's only a single stick (ie. not
> dual-channel)? It works fine with both sticks, individually, just not both
> together... I wonder what the cause of it actually is...

Another thing that I would try is to tweak the /proc/sys/vm/dirty_ratio 
and /proc/sys/vm/dirty_background_ratio settings.

pdflush appears in your trace and with twice the RAM there is twice the 
dirty data to write out. Maybe choosing half the ratio in both settings 
with 2Gb of RAM would produce the same amount of dirty data as using 
just 1Gb of RAM with the original settings.

This is still a bug, though. This test would just give more debug 
information.

-- 
Paulo "grasping at straws" Marques - www.grupopie.com

"The face of a child can say it all, especially the
mouth part of the face."

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262989AbUKYACv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262989AbUKYACv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 19:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262943AbUKYAAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 19:00:23 -0500
Received: from fsmlabs.com ([168.103.115.128]:33203 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S263001AbUKXXz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 18:55:27 -0500
Date: Wed, 24 Nov 2004 14:55:50 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Nigel Cunningham <ncunningham@linuxmail.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 22/51: Suspend2 lowlevel code.
In-Reply-To: <1101331206.3895.40.camel@desktop.cunninghams>
Message-ID: <Pine.LNX.4.61.0411241453230.7171@musoma.fsmlabs.com>
References: <1101292194.5805.180.camel@desktop.cunninghams> 
 <1101296166.5805.279.camel@desktop.cunninghams> 
 <Pine.LNX.4.61.0411240931470.7171@musoma.fsmlabs.com>
 <1101331206.3895.40.camel@desktop.cunninghams>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Nov 2004, Nigel Cunningham wrote:

> That's roughly what we're doing now, apart from the offlining/onlining.
> I had considered trying to take better advantage of SMP support (perhaps
> run a decompression thread on one CPU and the writer on the other, eg),
> so we might want to apply this just to the region immediately around the
> atomic copy/restore. That makes me wonder, though, what the advantage is
> to switching to using the hotplug functionality - is it x86 only, or
> more cross platform? (If more cross platform, that might possibly be an
> advantage over the current code).

It's cross platform and removes the requirement for patches like;

Subject: Suspend 2 merge: 13/51: Disable highmem tlb flush for copyback.

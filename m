Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267856AbUJONtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267856AbUJONtr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 09:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267798AbUJONrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 09:47:05 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:14736 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S267776AbUJONqZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 09:46:25 -0400
Message-ID: <416FD4C0.3090403@drzeus.cx>
Date: Fri, 15 Oct 2004 15:46:40 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040919)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Horman <nhorman@redhat.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Tasklet usage?
References: <416FCD3E.8010605@drzeus.cx> <416FD177.1050404@redhat.com>
In-Reply-To: <416FD177.1050404@redhat.com>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Horman wrote:

> Pierre Ossman wrote:

>> * Can tasklets be preempted?
>
> A tasklet can get preempted by a hard interrupt, but tasklets run in 
> interrupt context, so don't do anything in a tasklet that can call 
> schedule.

Being preempted by hard interrupts is sort of the point of moving the 
stuff to a tasklet. Just as long as other tasklets and user space cannot 
preempt it.

Are there any concerns when it comes to locking and tasklets? I've tried 
finding kernel-locking-HOWTO referenced in kernel-docs.txt but the link 
is dead and I can't find a mirror.

Rgds
Pierre


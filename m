Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262881AbUCJXzT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 18:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262889AbUCJXzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 18:55:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:4533 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262881AbUCJXzM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 18:55:12 -0500
Date: Wed, 10 Mar 2004 15:57:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Brad Laue <brad@brad-x.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ksoftirqd using mysteriously high amounts of CPU time
Message-Id: <20040310155712.7472e31c.akpm@osdl.org>
In-Reply-To: <404F85A6.6070505@brad-x.com>
References: <404F85A6.6070505@brad-x.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Laue <brad@brad-x.com> wrote:
>
> I'm running into an issue where ksoftirqd/0 consumes a considerably 
> larger amount of CPU time  than it should, and begins to actively 
> consume 99% CPU time during network operations.

Please ensure that the machine was booted with `profile=1' on
the kernel boot command line.  The cost of this is negligible.

When the problem starts happening, run:

sudo readprofile -r
sleep 10
sudo readprofile -n -v -m /boot/System.map | sort -n +2 | tail -40

(make sure that /boot/System.map refers to the currently-running kernel)

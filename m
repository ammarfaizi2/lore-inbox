Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262677AbVEGEPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262677AbVEGEPl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 00:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbVEGEPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 00:15:40 -0400
Received: from fire.osdl.org ([65.172.181.4]:56999 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262677AbVEGEPh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 00:15:37 -0400
Date: Fri, 6 May 2005 21:14:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: nico-kernel@schottelius.org, linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo format - arch dependent!
Message-Id: <20050506211455.3d2b3f29.akpm@osdl.org>
In-Reply-To: <Pine.GSO.4.33.0505062324550.1894-100000@sweetums.bluetronic.net>
References: <20050419121530.GB23282@schottelius.org>
	<Pine.GSO.4.33.0505062324550.1894-100000@sweetums.bluetronic.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ricky Beam <jfbeam@bluetronic.net> wrote:
>
> Short of a kernel module to export the kernel variables, that's the only
>  damned way to find the number of cpus in a Linux system.

Question is: do you need to know the number of CPUs (why?) or do you need
to know the number of CPUs which you're currently allowed to use or do you
need to know the maximum number of CPUs which you are allowed to bind
yourself to, or what?

Probably these things can be worked out via the get/set_affinity() syscalls
and/or via the cpuset sysfs interfaces, but it isn't as simple as you're
assuming.

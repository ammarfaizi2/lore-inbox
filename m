Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbVIEGqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbVIEGqk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 02:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbVIEGqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 02:46:40 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:22470 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932259AbVIEGqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 02:46:40 -0400
Message-ID: <431BE9CE.8080302@comcast.net>
Date: Mon, 05 Sep 2005 02:46:38 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bob Richmond <bob@lorez.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Immediate general protection errors on Tyan board
References: <431BE71F.2040901@lorez.org>
In-Reply-To: <431BE71F.2040901@lorez.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Richmond wrote:

> Immediately upon boot on this system, most userland programs will 
> segfault, including mount. This causes the system to come up in a 
> bizarre state with the root filesystem mounted read-only, and nothing 
> runs without segfault. There have been numerous similar posts about 
> this problem, but they also seem to point to an associated kernel 
> message, "Bad page state" that I don't observe. dmesg (which runs 
> without segfault) returns many similar messages to:
>
> start_udev[576] general protection rip:2aaaaae0fc70 rsp:7fffffb23d90 
> error:0

echo 0 > /proc/sys/kernel/randomize_va_space - Seems to fix it for most 
people.

See http://bugzilla.kernel.org/show_bug.cgi?id=4851 for more details.

Parag

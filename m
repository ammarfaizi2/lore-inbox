Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266257AbUGOSA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266257AbUGOSA2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 14:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266263AbUGOSA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 14:00:28 -0400
Received: from zero.aec.at ([193.170.194.10]:41994 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266257AbUGOSA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 14:00:27 -0400
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
cc: linux-kernel@vger.kernel.org
Subject: Re: tcp_window_scaling degrades performance
References: <2igbK-82L-13@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Thu, 15 Jul 2004 20:00:08 +0200
In-Reply-To: <2igbK-82L-13@gated-at.bofh.it> (Maciej Soltysiak's message of
 "Thu, 15 Jul 2004 17:20:08 +0200")
Message-ID: <m3zn615exj.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Soltysiak <solt@dns.toxicfilms.tv> writes:


> I have been experiencied weird problems with network throughput
> lately and I after experimenting with /proc/sys/net/ipv4 knobs
> I found that when I have tcp_window_scaling 0 I can
> get throughput from a distant server of about 600kB/s (well, 200kB/s
> is fast enough)

It's pretty easy for you to find out. Do a tcpdump -v or ethereal -v 
from both the side of a host you download from and from the linux side.
Then compare all packets. If they don't match the firewall is 
doing something bad. Especially check window values and TCP options
in the SYN packets

It is very very likely the firewall, window scaling works for a lot
of people.

-Andi


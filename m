Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbWCCNnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbWCCNnj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 08:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWCCNnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 08:43:39 -0500
Received: from mail.suse.de ([195.135.220.2]:61117 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751446AbWCCNnj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 08:43:39 -0500
To: Oumer Teyeb <oumer@kom.aau.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP control block interdependence
References: <44081B7B.5060104@kom.aau.dk>
From: Andi Kleen <ak@suse.de>
Date: 03 Mar 2006 14:43:35 +0100
In-Reply-To: <44081B7B.5060104@kom.aau.dk>
Message-ID: <p73d5h3d4oo.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oumer Teyeb <oumer@kom.aau.dk> writes:
 
>  From these I conclude that there is some TCP congestion control and
> retransmission parameter caching, that is also time dependant....
> and I want to disable it completley...

There is yes.
 
> So in short do you know how to disable this control block
> interdepence? 

echo 1 > /proc/sys/net/ipv4/tcp_no_metrics_save

> by the way I am using debian linux distribution and "uname -a" gives me
> Linux 2.4.25-std #1 SMP Mon Mar 22 10:25:51 CET 2004 i686 unknown

I don't know if that sysctl was already in 2.4 and it's unclear
if it makes sense to do any tests on such an old codebase anyways.
Better use a 2.6 kernel.

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265828AbTBCAUY>; Sun, 2 Feb 2003 19:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265843AbTBCAUY>; Sun, 2 Feb 2003 19:20:24 -0500
Received: from ns.suse.de ([213.95.15.193]:50188 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265828AbTBCAUX>;
	Sun, 2 Feb 2003 19:20:23 -0500
To: "Carlos Velasco" <carlosev@newipnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 Broken Path MTU Discovery?
References: <200302021958160177.2A4B5622@192.168.128.16.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 03 Feb 2003 01:29:51 +0100
In-Reply-To: "Carlos Velasco"'s message of "2 Feb 2003 20:03:18 +0100"
Message-ID: <p738ywyqk8w.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Carlos Velasco" <carlosev@newipnet.com> writes:
> 
> ¿May be the Linux box is giving up PMTU? ¿Why? it now knows MTU is 400.
> I have others windows boxes in the network, they work fine with PMTU.

A MTU of 400 is illegal, IPv4 requires a minimum MTU of 576 bytes. Below
it linux uses the minimum MTU and turns off path mtu discovery (=
drops DF)

You can change that minimum mtu by changing the ip_rt_min_pmtu variable
(no sysctl, you have to change it in /dev/kmem or recompile) 

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbWDHKmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbWDHKmy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 06:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWDHKmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 06:42:54 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:23774 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S964847AbWDHKmx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 06:42:53 -0400
Date: Sat, 8 Apr 2006 12:42:44 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: shemminger@osdl.org, jgarzik@pobox.com, akpm@osdl.org,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       fpavlic@de.ibm.com, davem@sunset.davemloft.net
Subject: Re: [patch] ipv4: initialize arp_tbl rw lock
Message-ID: <20060408104244.GB9412@osiris.boeblingen.de.ibm.com>
References: <20060407081533.GC11353@osiris.boeblingen.de.ibm.com> <20060407074627.2f525b2e@localhost.localdomain> <20060408100213.GA9412@osiris.boeblingen.de.ibm.com> <20060408.031404.111884281.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060408.031404.111884281.davem@davemloft.net>
User-Agent: mutt-ng/devel-r796 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We could make inet_init() a subsystem init but I vaguely recall
> that we were doing that at one point and it broke things for
> some reason.
> 
> Perhaps fs_initcall() would work better.  Or if that causes
> problems we could create a net_initcall() that sits between
> fs_initcall() and device_initcall().
> 
> Or any other ideas?

Just tried fs_initcall() and net_initcall(). Both seem to have some
side effects:
Symptom is that console output sometimes hangs for several seconds at:
"NET: Registered protocol family 2" while all cpus are in cpu_idle().

Heiko

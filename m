Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267457AbTAQJXM>; Fri, 17 Jan 2003 04:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267448AbTAQJXM>; Fri, 17 Jan 2003 04:23:12 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:61180 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S267449AbTAQJXL>; Fri, 17 Jan 2003 04:23:11 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20030117085728.1C0FF2C186@lists.samba.org> 
References: <20030117085728.1C0FF2C186@lists.samba.org> 
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, davem@vger.kernel.org
Subject: Re: [module-init-tools] fix weak symbol handling 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 17 Jan 2003 09:32:09 +0000
Message-ID: <2607.1042795929@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


rusty@rustcorp.com.au said:
>  If A depends on B, then modprobe will give a warning if "modprobe A"
> fails to load B for some reason.  If B doesn't exist, then modprobe
> wouldn't know anything about it (presumably).

A warning is fine. If A _weakly_ depends on B, a failure to load A even 
though B decided when asked that it didn't really want to initialise itself
is not fine :)

--
dwmw2



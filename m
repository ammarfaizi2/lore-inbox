Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755627AbWKQJig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755627AbWKQJig (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 04:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755624AbWKQJig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 04:38:36 -0500
Received: from test.estpak.ee ([194.126.115.47]:7388 "EHLO devy.estpak.ee")
	by vger.kernel.org with ESMTP id S1755626AbWKQJif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 04:38:35 -0500
From: Hasso Tepper <hasso@estpak.ee>
To: Andi Kleen <ak@suse.de>
Subject: Re: Sysctl syscall
Date: Fri, 17 Nov 2006 11:38:33 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <200611160003.02681.hasso@estpak.ee> <200611171007.57596.hasso@estpak.ee> <200611171023.45595.ak@suse.de>
In-Reply-To: <200611171023.45595.ak@suse.de>
Organization: Elion Enterprises Ltd.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611171138.33469.hasso@estpak.ee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Friday 17 November 2006 09:07, Hasso Tepper wrote:
> > I have process which drops root privileges after startup and retains
> > only some privileges using CAP_NET_ADMIN and CAP_SYS_ADMIN
> > capabilities. I can change values in /proc/sys/net/ipv[46]/* (like
> > turning forwarding on/off) from this process using sysctl syscall,
> > but I can't write directly into /proc/sys/net/ipv[46]/* from it.
>
> That sounds more like a security bug than a feature to be preserved.

Why? IMHO it's normal that process with CAP_NET_ADMIN capabilities can 
modify settings in /proc/sys/net/. From /usr/include/sys/capability.h:

/* Allow interface configuration */
/* Allow administration of IP firewall, masquerading and accounting */
/* Allow setting debug option on sockets */
/* Allow modification of routing tables */
/* Allow setting arbitrary process / process group ownership on
   sockets */
/* Allow binding to any address for transparent proxying */
/* Allow setting TOS (type of service) */
/* Allow setting promiscuous mode */
/* Allow clearing driver statistics */
/* Allow multicasting */
/* Allow read/write of device-specific registers */
/* Allow activation of ATM control sockets */

#define CAP_NET_ADMIN        12


regards,

-- 
Hasso Tepper
Elion Enterprises Ltd. [AS3249]
Data Communication Network Administrator

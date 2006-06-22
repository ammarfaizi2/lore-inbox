Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbWFVIyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbWFVIyZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 04:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWFVIyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 04:54:24 -0400
Received: from test.estpak.ee ([194.126.115.47]:43476 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932454AbWFVIyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 04:54:23 -0400
From: Hasso Tepper <hasso@estpak.ee>
To: netdev@vger.kernel.org
Subject: Re: No interfaces under /proc/sys/net/ipv4/conf/
Date: Thu, 22 Jun 2006 11:54:20 +0300
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200606211631.39656.hasso@estpak.ee>
In-Reply-To: <200606211631.39656.hasso@estpak.ee>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606221154.20999.hasso@estpak.ee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hasso Tepper wrote:
> After upgrade to 2.6.16.20 from 2.6.11 I discovered that no dynamic
> interfaces (vlans, tunnels) appear under /proc/sys/net/ipv4/conf/.
> /proc/sys/net/ipv6/conf/ is OK.

OK, realised out that it's feature. Entries in /proc/sys/net/*/conf/ are 
not created if interface doesn't have at least one ipv4/ipv6 address.

I can think of workarounds for most of problems (although it breaks a hell 
lot of software here), but how I suppose to configure ipv6 settings for 
interfaces which have to obtain global ipv6 address via autoconf so that 
it will work even if cable is not plugged in? I did via /etc/sysctl.conf,
but now ... machine boots with no link => no link-local address => 
no /proc/sys/net/ipv6/conf/<interfce> => configuration fails.


regards,

-- 
Hasso Tepper


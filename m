Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbVCGKvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbVCGKvw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 05:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVCGKvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 05:51:52 -0500
Received: from yakov.inr.ac.ru ([194.67.69.111]:8098 "HELO yakov.inr.ac.ru")
	by vger.kernel.org with SMTP id S261740AbVCGKvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 05:51:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=P9J2xkV/dL2Cj5vMXzq8/OZj5rdObkmhLoE7CCcqNFOABKGoeLjAEGlmiEN97LJ1DN1/MPBjuvgawp+Ec/n/KCxeIHBsf6bTuS9eREe8iE+1SVRD8WP1Sqxs8XAJ4sg6H9lD8eUMg5CETEEpE/SJCDMCGuw204cYV2so/IrgP0M=;
Date: Mon, 7 Mar 2005 13:51:38 +0300
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: Ben Greear <greearb@candelatech.com>
Cc: "leo.yuriev.ru" <leo@yuriev.ru>, Lennert Buytenhek <buytenh@gnu.org>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ethernet-bridge: update skb->priority in case forwarded frame has VLAN-header
Message-ID: <20050307105138.GA19869@yakov.inr.ac.ru>
References: <1199527299.20050305165713@yuriev.ru> <422BABCE.3030904@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422BABCE.3030904@candelatech.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> If this packet came in from an 802.1Q VLAN device, the VLAN code already
> has the logic necessary to map the .1q priority to an arbitrary 
> skb->priority.

Actually, the patch makes sense when it is straight ethernet bridge
not involving full parsing of VLAN. I guess the case when the frame
passed through VLAN device should be eliminated to avoid overwriting
priority set by VLAN.

Alexey

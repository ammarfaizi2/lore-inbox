Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbWI0SfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbWI0SfQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 14:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965145AbWI0SfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 14:35:16 -0400
Received: from smtp.bulldogdsl.com ([212.158.248.8]:21775 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S964872AbWI0SfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 14:35:14 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Martin Filip <bugtraq@smoula.net>
Subject: Re: forcedeth - WOL
Date: Wed, 27 Sep 2006 19:35:12 +0100
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <1159379441.9024.7.camel@archon.smoula-in.net>
In-Reply-To: <1159379441.9024.7.camel@archon.smoula-in.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609271935.12969.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 September 2006 18:50, Martin Filip wrote:
> Hi to LKML,
>
> I'm experiencing some troubles with WOL with my nForce NIC.
> The problem is simple - after setting WOL mode to magic packet my PC
> won't wake up. I've noticed there were some changes about this in new
> kernel, but no luck for me.
>
> I'm using 2.6.18 kernel, vanilla. I've tried this with Windows Vista RC1
> (build 5600) and WOL works correctly. My NIC is integrated on MSI K8N
> Neo4-FI

On my nForce4 CK804 it's disabled by default, I bet this is your problem:

[root] 19:33 [~] ethtool lan
Settings for lan:
        Supported ports: [ MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Supports auto-negotiation: Yes
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Advertised auto-negotiation: Yes
        Speed: 100Mb/s
        Duplex: Full
        Port: MII
        PHYAD: 1
        Transceiver: external
        Auto-negotiation: on
        Supports Wake-on: g
        Wake-on: d
        Link detected: yes

Read the manpage for ethtool. HTH.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.

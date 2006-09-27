Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030522AbWI0SjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030522AbWI0SjB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 14:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030525AbWI0SjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 14:39:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:6369 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030522AbWI0SjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 14:39:00 -0400
X-Authenticated: #5039886
Date: Wed, 27 Sep 2006 20:38:58 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Martin Filip <bugtraq@smoula.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: forcedeth - WOL
Message-ID: <20060927183857.GA2963@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Martin Filip <bugtraq@smoula.net>, linux-kernel@vger.kernel.org
References: <1159379441.9024.7.camel@archon.smoula-in.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1159379441.9024.7.camel@archon.smoula-in.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.09.27 19:50:41 +0200, Martin Filip wrote:
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
> 
> Is there any way how can I help with developement of this feature?

Did you check that WOL was enabled? I need to re-activate it after each
boot (I guess that's normal, not sure though).
The output of "ethtool eth0" should show:

        Supports Wake-on: g
        Wake-on: g

Also, I remember a bugzilla entry in which it was said that the MAC was
somehow reversed by the driver. I that is still the case (I can't find
the bugzilla entry right now), you might just reverse the MAC address in
your WOL packet to workaround the bug.

HTH
Björn

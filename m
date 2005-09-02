Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161115AbVIBXOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161115AbVIBXOf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 19:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161121AbVIBXOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 19:14:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15233 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161115AbVIBXOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 19:14:34 -0400
Date: Fri, 2 Sep 2005 19:14:23 -0400
From: Dave Jones <davej@redhat.com>
To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: agp_backend_initialize() failed on ServerWorks CNB20LE
Message-ID: <20050902231423.GD24062@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
	linux-kernel@vger.kernel.org
References: <1957123248.20050902232139@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1957123248.20050902232139@dns.toxicfilms.tv>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2005 at 11:21:39PM +0200, Maciej Soltysiak wrote:
 > Hello,
 > 
 > On a server with ServerWorks CNB20LE and CONFIG_AGP_SWORKS enabled
 > I get these upon bootup:
 > Linux agpgart interface v0.101 (c) Dave Jones
 > agpgart: unable to determine aperture size.
 > agpgart: agp_backend_initialize() failed.
 > agpgart-serverworks: probe of 0000:00:00.0 failed with error -22
 > agpgart: unable to determine aperture size.
 > agpgart: agp_backend_initialize() failed.
 > agpgart-serverworks: probe of 0000:00:00.1 failed with error -22

Every time I've seen this reported so far, its turned out that the board
doesn't actually have an AGP slot. Is this case here too ?

Documentation on serverworks chipsets is as good as non-existant,
so there's not a great deal we can do here.

 > The only problems I have that *may* be related to these messages is the
 > fact that when I boot into X and try to switch to a text console, the
 > screen gets garbled and freezes, the server works fine besides the
 > screen throwing trash at me.

Likely completely unrelated. agpgart is used only for accelerated 3d.

		Dave


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWEPP2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWEPP2e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWEPP2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:28:34 -0400
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:18381 "EHLO
	mail7.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932095AbWEPP2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:28:32 -0400
Date: Tue, 16 May 2006 11:28:28 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Matt Ayres <matta@tektonic.net>
cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Patrick McHardy <kaber@trash.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] Re: Panic in ipt_do_table with 2.6.16.13-xen
In-Reply-To: <4469D84F.8080709@tektonic.net>
Message-ID: <Pine.LNX.4.64.0605161127030.16379@d.namei>
References: <4468BE70.7030802@tektonic.net> <4468D613.20309@trash.net>
 <44691669.4080903@tektonic.net> <Pine.LNX.4.64.0605152331140.10964@d.namei>
 <4469D84F.8080709@tektonic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2006, Matt Ayres wrote:

> > > My ruleset is pretty bland.  2 rules in the raw table to tell the system
> > > to
> > > only track my forwarded ports, 2 rules in the nat table for forwarding
> > > (intercepting) 2 ports, and then in the FORWARD tables 2 rules per VM to
> > > just
> > > account traffic.
> > 
> > Can you try using a different NIC?
> > 
> 
> This happens on 30 different hosts.  Using the same kernel I get varying
> uptime of "hasn't crashed since the upgrade to 2.6.16" to "crashes every day".
> All are Tyan S2882D boards w/ integrated Tigon3.  The trace I posted to this
> thread indicate tg3, but in many other traces I have the trace doesn't include
> any driver calls.  They all panic in ipt_do_table.  I would have pasted the
> others, but I didn't save the System.map for either of them and they are all
> pretty similar.

I'm trying to suggest eliminating this driver & possible interaction with 
Xen network changes as a cause.  If you can find a different type of NIC 
to plug in and use, or even try and change all of the params for the tg3 
with ethtool, it'll help.

-- 
James Morris
<jmorris@namei.org>

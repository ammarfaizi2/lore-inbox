Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264929AbUGGGbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264929AbUGGGbF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 02:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264931AbUGGGbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 02:31:05 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:50851 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S264929AbUGGGbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 02:31:00 -0400
Date: Wed, 7 Jul 2004 08:31:00 +0200
From: bert hubert <ahu@ds9a.nl>
To: Redeeman <lkml@metanurb.dk>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: quite big breakthrough in the BAD network performance, which mm6 did not fix
Message-ID: <20040707063100.GA18382@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Redeeman <lkml@metanurb.dk>,
	LKML Mailinglist <linux-kernel@vger.kernel.org>,
	Horst von Brand <vonbrand@inf.utfsm.cl>
References: <200407061930.i66JUpqI009671@eeyore.valparaiso.cl> <1089160973.903.1.camel@localhost> <200407061812.24526.lkml@lpbproductions.com> <1089179186.10677.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089179186.10677.8.camel@localhost>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 07:46:26AM +0200, Redeeman wrote:
> this must be some misunderstanding, i do not want to complain, and i
> dont hope people get that impression, i am trying to do feedback, so
> that issues can be fixed.

Redeeman - your firewall is broken, or somebody's firewall. 

Look at  /proc/sys/net/ipv4/tcp_default_win_scale , if it currently contains
7, do:

echo 1 > /proc/sys/net/ipv4/tcp_default_win_scale

and retry.

> downloads with 200kb/s from http://kernel.org, and 2.6.7 only 50kb/s,
> this should be able to prove its some issues with 2.6.7, but thats just
> my opinion

Things can be more complicated than they appear. Currently all evidence for
these changes points to firewalls messing with TCP options, TCP options
which used to have more default versions in older kernels.

Regards,

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO

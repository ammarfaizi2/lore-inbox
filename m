Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbVBWL7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVBWL7X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 06:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbVBWL7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 06:59:23 -0500
Received: from mail.olografix.org ([195.32.69.44]:23243 "EHLO
	mail.olografix.org") by vger.kernel.org with ESMTP id S261469AbVBWL7R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 06:59:17 -0500
Date: Wed, 23 Feb 2005 12:58:46 +0100
From: "Angelo Dell'Aera" <buffer@olografix.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: mlists@danielinux.net, "David S. Miller" <davem@davemloft.net>,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       Carlo Caini <ccaini@deis.unibo.it>,
       Rosario Firrincieli <rfirrincieli@arces.unibo.it>
Subject: Re: [PATCH] TCP-Hybla proposal
Message-ID: <20050223125846.674b6175@alnitak.darkstar.net>
In-Reply-To: <20050222094219.0a8efbe1@dxpl.pdx.osdl.net>
References: <200502221534.42948.mlists@danielinux.net>
	<20050222094219.0a8efbe1@dxpl.pdx.osdl.net>
Organization: Antifork Research, Inc.
X-Mailer: Sylpheed-Claws 1.0.1 (GTK+ 1.2.10; i386-portbld-freebsd5.3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2005 09:42:19 -0800
Stephen Hemminger <shemminger@osdl.org> wrote:


> Probably the best long term solution is to make the protocol choice
> be a property of the destination cache 

[..]
> The protocol choices are mutually exclusive, if you walk through the code
> (or do experiments), you find that that only one gets used.  As part of the
> longer term plan, I would like to:
> 	- have one sysctl
> 	- choice by route and destination
> 	- union for fields in control block


I think it should be nice if we substitute in the struct tcp_opt all the structs
related to the congestion control algorithms with a more generic one which could 
be initialized when the connection is open by reading just one sysctl which defines
the algorithm to be used. This could allow later even a user-space application to
set the congestion control it desires to use.   


> Is there interest in setting up a semi official "-tcp" tree to hold these?
> because it might not be of wide interest or stability to be ready for mainline
> kernel.

I perfectly agree.


--

Angelo Dell'Aera 'buffer' 
Antifork Research, Inc.	  	http://buffer.antifork.org
Metro Olografix


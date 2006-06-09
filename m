Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030247AbWFIQBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbWFIQBG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbWFIQBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:01:06 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:53935 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030247AbWFIQBF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:01:05 -0400
Date: Fri, 9 Jun 2006 18:00:35 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Paul Fulghum <paulkf@microgate.com>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, khc@pm.waw.pl
Subject: Re: [PATCH] fix generic HDLC synclink mismatch build error
In-Reply-To: <1149868042.20097.5.camel@amdx2.microgate.com>
Message-ID: <Pine.LNX.4.64.0606091757260.17704@scrub.home>
References: <1149694978.12920.14.camel@amdx2.microgate.com> 
 <20060607143138.62855633.rdunlap@xenotime.net> <1149868042.20097.5.camel@amdx2.microgate.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 9 Jun 2006, Paul Fulghum wrote:

> +config SYNCLINK_HDLC
> +	bool "Generic HDLC support for SyncLink driver"
> +	depends on SYNCLINK
> +	depends on HDLC=y || HDLC=SYNCLINK

If you replace now 'bool "..."' with 'def_bool y', it's enabled 
automatically as soon as HDLC is enabled and the user doesn't has to 
confirm it for every driver separately and it has the same effect as your 
#ifdef hack.

bye, Roman

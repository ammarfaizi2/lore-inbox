Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbWFHCfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbWFHCfr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 22:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbWFHCfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 22:35:46 -0400
Received: from xenotime.net ([66.160.160.81]:56524 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932489AbWFHCfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 22:35:46 -0400
Date: Wed, 7 Jun 2006 19:38:33 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Paul Fulghum <paulkf@microgate.com>
Cc: zippel@linux-m68k.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix generic HDLC synclink mismatch build error
Message-Id: <20060607193833.e34c5827.rdunlap@xenotime.net>
In-Reply-To: <44876DF9.3070205@microgate.com>
References: <1149694978.12920.14.camel@amdx2.microgate.com>
	<Pine.LNX.4.64.0606080044350.17704@scrub.home>
	<44876DF9.3070205@microgate.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Jun 2006 19:23:21 -0500 Paul Fulghum wrote:

> Roman Zippel wrote:
> > Hi,
> > 
> > On Wed, 7 Jun 2006, Paul Fulghum wrote:
> > 
> > 
> >>-#ifdef CONFIG_HDLC_MODULE
> >>+#if defined(CONFIG_HDLC_MODULE) && defined(CONFIG_SYNCLINK_MODULE)
> >> #define CONFIG_HDLC 1
> >> #endif
> > 
> > 
> > Please don't define your own config symbols, just use Kconfig for this, 
> > simply remove the prompts from your earlier patch and add the dependecies 
> > as Randy suggested.
> 
> Randy's patch defines config symbols, so I don't know what you are getting at.

Yes, but in the config language, not inside a driver source file.

---
~Randy

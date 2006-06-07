Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbWFGW7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbWFGW7U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 18:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbWFGW7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 18:59:20 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:44957 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932457AbWFGW7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 18:59:19 -0400
Date: Thu, 8 Jun 2006 00:58:53 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Paul Fulghum <paulkf@microgate.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix generic HDLC synclink mismatch build error
In-Reply-To: <1149694978.12920.14.camel@amdx2.microgate.com>
Message-ID: <Pine.LNX.4.64.0606080044350.17704@scrub.home>
References: <1149694978.12920.14.camel@amdx2.microgate.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 7 Jun 2006, Paul Fulghum wrote:

> -#ifdef CONFIG_HDLC_MODULE
> +#if defined(CONFIG_HDLC_MODULE) && defined(CONFIG_SYNCLINK_MODULE)
>  #define CONFIG_HDLC 1
>  #endif

Please don't define your own config symbols, just use Kconfig for this, 
simply remove the prompts from your earlier patch and add the dependecies 
as Randy suggested.

bye, Roman

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWIUFy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWIUFy7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 01:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWIUFy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 01:54:59 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:20621 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1750871AbWIUFy6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 01:54:58 -0400
Message-ID: <45122930.10105@drzeus.cx>
Date: Thu, 21 Sep 2006 07:54:56 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Alex Dubov <oakad@yahoo.com>
CC: linux-kernel@vger.kernel.org, rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH 2/2] [MMC] Driver for TI FlashMedia card reader - Kconfig/Makefile
 entries
References: <20060921030232.30990.qmail@web36704.mail.mud.yahoo.com>
In-Reply-To: <20060921030232.30990.qmail@web36704.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Dubov wrote:
>
> I kind of fail to follow here. Do you want to switch TIFM_CORE -> MMC_TIFM_SD dependency into
> MMC_TIFM_SD -> TIFM_CORE + TIFM_7XX1 one? It may be slightly more convenient for users (even
> though most are using pre-compiled kernels provided by distribution), but will be logically
> incorrect, doesn't it? And then, what will become of memorystick driver?
>
>   

No no, I want a change from "depends" to "select". That symbolises the
same dependency, but it has slightly different semantics (which it
probably shouldn't, but that's another discussion). With "depends", a
config entry is hidden if its dependencies aren't satisfied. With
"select", it will forcefully enable those dependencies.

>From a user point of view, the former requires knowledge of how all of
these things hangs together (which is expecting a bit much), but the
latter will automatically pull in all the components needed to build the
option the user selects (which is how dependencies should work IMO).

Rgds
Pierre


> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around 
> http://mail.yahoo.com 
>   


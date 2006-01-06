Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932664AbWAFXnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932664AbWAFXnh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 18:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932662AbWAFXnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 18:43:37 -0500
Received: from [85.8.13.51] ([85.8.13.51]:37569 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S932279AbWAFXnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 18:43:37 -0500
Message-ID: <43BF00A4.8070606@drzeus.cx>
Date: Sat, 07 Jan 2006 00:43:32 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mail/News 1.5 (X11/20060103)
MIME-Version: 1.0
To: jordan.crouse@amd.com
CC: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Minimise protocol awareness in Au1x00 driver
References: <20060106234012.31480.88314.stgit@poseidon.drzeus.cx>
In-Reply-To: <20060106234012.31480.88314.stgit@poseidon.drzeus.cx>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:
> The Au1x00 MMC/SD driver currently contains switch statements based on
> protocol opcodes, not on desired behaviour.
>
> Unfortunately the AMD specification is not detailed enough to determine
> how the controller will behave for the response settings. For now, it will
> have to suffice to warn when we have an unknown response type.
>
> Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
> ---
>
>   

Whilst doing this I also noticed how horribly broken this driver is with
regard to sending the stop command. Instead of sending the requested
command it sends a hard coded opcode!! Jordan, please fix this ASAP.

Rgds
Pierre




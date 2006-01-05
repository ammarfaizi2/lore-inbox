Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030438AbWAGNLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030438AbWAGNLU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 08:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030439AbWAGNLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 08:11:20 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:65286 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1030438AbWAGNLT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 08:11:19 -0500
Date: Thu, 5 Jan 2006 23:43:28 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Jan Spitalnik <lkml@spitalnik.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Disable swsusp on CONFIG_HIGHMEM64
Message-ID: <20060105234327.GA2951@ucw.cz>
References: <200601061945.09466.lkml@spitalnik.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601061945.09466.lkml@spitalnik.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 06-01-06 19:45:09, Jan Spitalnik wrote:
> Hello,
> 
> suspending to disk is not supported on CONFIG_HIGHMEM64G setups 
> (http://suspend2.net/features). Also suspend to ram doesn't work. This patch 

NAK. suspend2.net describes very different code.

> fixes Kconfig to disallow such combination. I'm not 100% sure about the 
> ACPI_SLEEP part, as it might be disabling some working setup - but i think 
> that s2r and s2d are the only acpi sleeps allowed, no?

s2ram probably works. Try getting it working without highmem64,
then turn it on.

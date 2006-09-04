Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbWIDOl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbWIDOl4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 10:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWIDOl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 10:41:56 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:43659 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751436AbWIDOlz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 10:41:55 -0400
Message-ID: <44FC3B2E.106@drzeus.cx>
Date: Mon, 04 Sep 2006 16:41:50 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Alex Dubov <oakad@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash
 card readers
References: <20060904142811.21367.qmail@web36714.mail.mud.yahoo.com>
In-Reply-To: <20060904142811.21367.qmail@web36714.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Dubov wrote:
>
> If I understand correctly, there should be two different ways to report bytes_xfered:
> 1. for read operations, the current block/byte counter reporting is sufficient
>   

It should be the number of successfully received bytes all the way to
the kernel. But this is difficult to get wrong. ;)

> 2. for write operation, error-less BUSY assert/de-assert pairs shall be counted instead
> Currently I only look at the last BUSY de-assert to verify that command is completed successfully.
> As mmc_block always issues single block writes it is sufficient. If this will ever change, more
> sophisticated scheme can be devised.
>
>   

This is about to change. Hence the need to check that all drivers are
reporting what they're supposed to.

Rgds
Pierre


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266143AbUGOIPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266143AbUGOIPl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 04:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266139AbUGOIPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 04:15:41 -0400
Received: from pc7.prs.nunet.net ([199.249.167.77]:46860 "HELO
	patternassociates.com") by vger.kernel.org with SMTP
	id S266143AbUGOIP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 04:15:28 -0400
Date: 15 Jul 2004 08:15:19 -0000
Message-ID: <20040715081519.17203.qmail@patternassociates.com>
From: "Rico Tudor" <rico-linux-kernel-2004@patternassociates.com>
To: dwoods@fastclick.com
Subject: Re: Problems with DMA on IDE/ServerWorks/Seagate.
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Date:	Wed, 14 Jul 2004 17:16:14 -0700
>From:	"Dave Woods" <dwoods@fastclick.com>
>...
>We have diagnosed a problem (file corruption) using Ultra DMA & IDE with
>
>ServerWorks OSB4 Chipset and Seagate drives under heavy disk I/O.
>...

This chipset has buggy IDE DMA.

I maintain several boxes with OSB4 and IDE devices (HD, CDR-W, DVD-RW).
Best solution is using an add-on card (e.g. Promise Ultra66 card).
Otherwise, I found two configurations that always work: multi-device,
and single-device.  In multi-device, operate all devices in PIO -
no exceptions!  In single-device, meaning the other three interfaces
are unused, you can safely enable MW-DMA Mode 2.

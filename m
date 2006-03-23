Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWCWMKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWCWMKS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 07:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWCWMKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 07:10:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55457 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750754AbWCWMKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 07:10:16 -0500
Date: Thu, 23 Mar 2006 04:06:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Make libata not powerdown drivers on PM_EVENT_FREEZE.
Message-Id: <20060323040649.3a6c96f1.akpm@osdl.org>
In-Reply-To: <200603232151.47346.ncunningham@cyclades.com>
References: <200603232151.47346.ncunningham@cyclades.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@cyclades.com> wrote:
>
> At the moment libata doesn't pass pm_message_t down ata_device_suspend.
>  This causes drives to be powered down when we just want a freeze,
>  causing unnecessary wear and tear. This patch gets pm_message_t passed
>  down so that it can be used to determine whether to power down the
>  drive.

Does this explain http://bugzilla.kernel.org/show_bug.cgi?id=6264 ?

This might be 2.6.16.1 material - how irritating is it?

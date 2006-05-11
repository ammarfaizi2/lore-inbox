Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWEKSWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWEKSWe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 14:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWEKSWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 14:22:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9132 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750709AbWEKSWd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 14:22:33 -0400
Date: Thu, 11 May 2006 11:25:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: sekharan@us.ibm.com, jes@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow raw_notifier callouts to unregister themselves
Message-Id: <20060511112509.6c9db883.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0605111353210.5834-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0605111353210.5834-100000@iolanthe.rowland.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> wrote:
>
> Since raw_notifier chains don't benefit from any centralized locking
> protections, they shouldn't suffer from the associated limitations.  
> Under some circumstances it might make sense for a raw_notifier callout
> routine to unregister itself from the notifier chain.  This patch (as678)
> changes the notifier core to allow for such things.

ok...  Can you see any reason why 2.6.17 needs this?

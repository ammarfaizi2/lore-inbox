Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266307AbUGAVgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266307AbUGAVgx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 17:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266291AbUGAVgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 17:36:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:27070 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266303AbUGAVgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 17:36:10 -0400
Date: Thu, 1 Jul 2004 14:38:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kevin Corry <kevcorry@us.ibm.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 1/1: Device-Mapper: Remove 1024 devices limitation
Message-Id: <20040701143857.256959e5.akpm@osdl.org>
In-Reply-To: <200407011035.13283.kevcorry@us.ibm.com>
References: <200407011035.13283.kevcorry@us.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Corry <kevcorry@us.ibm.com> wrote:
>
> Remove the limitation of 1024 DM devices.

That seems to be an awful lot of fuss just to maintain a bitmap.

What is a realistic useful upper bound on the minors?  Would it not be sufficient
to increase the size of the statically allocated bitmap?

Did you consider going to a different data structure altogether?  lib/radix-tree.c and
lib/idr.c provide appropriate ones.

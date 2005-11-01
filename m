Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964962AbVKADZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbVKADZf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 22:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbVKADZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 22:25:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50106 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964962AbVKADZe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 22:25:34 -0500
Date: Mon, 31 Oct 2005 19:25:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: torvalds@osdl.org, kravetz@us.ibm.com, raybry@mpdtxmail.amd.com,
       linux-kernel@vger.kernel.org, lee.schermerhorn@hp.com,
       haveblue@us.ibm.com, clameter@sgi.com, magnus.damm@gmail.com,
       pj@sgi.com, marcelo.tosatti@cyclades.com,
       kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH 0/5] Swap Migration V5: Overview
Message-Id: <20051031192506.100d03fa.akpm@osdl.org>
In-Reply-To: <20051101031239.12488.76816.sendpatchset@schroedinger.engr.sgi.com>
References: <20051101031239.12488.76816.sendpatchset@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> This is a patchset intended to introduce page migration into the kernel
>  through a simple implementation of swap based page migration.
>  The aim is to be minimally intrusive in order to have some hopes for inclusion
>  into 2.6.15. A separate direct page migration patch is being developed that
>  applies on top of this patch. The direct migration patch is being discussed on
>  <lhms-devel@lists.sourceforge.net>.

I remain concerned that it hasn't been demonstrated that the infrastructure
which this patch provides will be adequate for all future applications -
especially memory hot-remove.

So I'll queue this up for -mm, but I think we need to see an entire
hot-remove implementation based on this, and have all the interested
parties signed up to it before we can start moving the infrastructure into
mainline.

Do you think the features which these patches add should be Kconfigurable?

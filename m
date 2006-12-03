Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760110AbWLCV0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760110AbWLCV0u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 16:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760126AbWLCV0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 16:26:44 -0500
Received: from smtp.osdl.org ([65.172.181.25]:16788 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1760107AbWLCV03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 16:26:29 -0500
Date: Sun, 3 Dec 2006 13:26:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: minyard@acm.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>,
       Joseph Barnett <jbarnett@motorola.com>
Subject: Re: [PATCH 9/12] IPMI: add pigeonpoint poweroff
Message-Id: <20061203132618.d7d58f59.akpm@osdl.org>
In-Reply-To: <20061202043746.GE30531@localdomain>
References: <20061202043746.GE30531@localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2006 22:37:46 -0600
Corey Minyard <minyard@acm.org> wrote:

> +static void (*atca_oem_poweroff_hook)(ipmi_user_t user) = NULL;

Sometime, please go through the IPMI code looking for all these
statically-allocated things which are initialised to 0 or NULL and remove
all those intialisations?  They're unneeded, they increase the vmlinux
image size and there are quite a number of them.  Thanks.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbVEYJIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVEYJIz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 05:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVEYJIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 05:08:55 -0400
Received: from fire.osdl.org ([65.172.181.4]:40664 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261537AbVEYJIy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 05:08:54 -0400
Date: Wed, 25 May 2005 02:07:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexander Nyberg <alexn@telia.com>
Cc: vgoyal@in.ibm.com, linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
Subject: Re: [Fastboot] [1/2] kdump: Use real pt_regs from exception
Message-Id: <20050525020749.1ad56a80.akpm@osdl.org>
In-Reply-To: <1116427862.22324.5.camel@localhost.localdomain>
References: <1116103798.6153.30.camel@localhost.localdomain>
	<20050518123500.GA3657@in.ibm.com>
	<1116427862.22324.5.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nyberg <alexn@telia.com> wrote:
>
> -extern void machine_crash_shutdown(void);
>  +extern void machine_crash_shutdown(struct pt_regs *);

That'll break x86_64, ppc, ppc64 and s/390.

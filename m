Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751444AbWGLQKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbWGLQKc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 12:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWGLQKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 12:10:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55680 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751444AbWGLQKc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 12:10:32 -0400
Date: Wed, 12 Jul 2006 09:10:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Peschke <mp3@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] statistics infrastructure - update 10
Message-Id: <20060712091024.c5bd19c7.akpm@osdl.org>
In-Reply-To: <1152707259.3028.7.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
References: <1152707259.3028.7.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2006 14:27:39 +0200
Martin Peschke <mp3@de.ibm.com> wrote:

> +#define statistic_ptr(stat, cpu) \
> +	((struct percpu_data*)((stat)->data))->ptrs[(cpu)]

This would be the only part of the kernel which uses percpu_data directly -
everything else uses the APIs (ie: per_cpu_ptr()).  How come?

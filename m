Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWCaSVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWCaSVW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 13:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWCaSVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 13:21:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9921 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932198AbWCaSVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 13:21:21 -0500
Date: Fri, 31 Mar 2006 10:20:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jes Sorensen <jes@sgi.com>
Cc: torvalds@osdl.org, ak@suse.de, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [patch] avoid unaligned access when accessing poll stack
Message-Id: <20060331102053.2a440f81.akpm@osdl.org>
In-Reply-To: <yq0sloytyj5.fsf@jaguar.mkp.net>
References: <yq0sloytyj5.fsf@jaguar.mkp.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen <jes@sgi.com> wrote:
>
>   [PATCH] Optimize select/poll by putting small data sets on the stack
>  resulted in the poll stack being 4-byte aligned on 64-bit
>  architectures, causing misaligned accesses to elements in the array.

How come you noticed this but I did not?

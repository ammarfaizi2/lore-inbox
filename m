Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264685AbTFLB0I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 21:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264687AbTFLB0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 21:26:08 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:1846 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264685AbTFLB0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 21:26:06 -0400
Date: Wed, 11 Jun 2003 18:40:45 -0700
From: Andrew Morton <akpm@digeo.com>
To: Steve French <smfrench@austin.rr.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Compiling kernel with SuSE 8.2/gcc 3.3
Message-Id: <20030611184045.21f1fc83.akpm@digeo.com>
In-Reply-To: <3EE7D659.2000003@austin.rr.com>
References: <3EE6B7A2.3000606@austin.rr.com.suse.lists.linux.kernel>
	<p73he6x59hf.fsf@oldwotan.suse.de>
	<3EE7D659.2000003@austin.rr.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Jun 2003 01:39:49.0958 (UTC) FILETIME=[8361CE60:01C33083]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve French <smfrench@austin.rr.com> wrote:
>
> Although it fixes it for building on 32 bit architectures, won't changing
> 
> 
>  	__u64 uid = 0xFFFFFFFFFFFFFFFF;
>  to
> 
>  	__u64 uid = 0xFFFFFFFFFFFFFFFFULL;
> 
>  generate a type mismatch warning on ppc64 and similar 64 bit
>  architecutres since __u64 is not a unsigned long long on ppc64 
>  (it is unsigned long)?

	u64 uid = -1;

will work just nicely.

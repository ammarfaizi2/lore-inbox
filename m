Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbUKBJgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbUKBJgj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 04:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbUKBJgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 04:36:38 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:48646 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261498AbUKBJgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 04:36:18 -0500
Date: Tue, 2 Nov 2004 09:36:10 +0000
From: Christoph Hellwig <hch@infradead.org>
To: dhowells@redhat.com
Cc: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com,
       linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: [PATCH 10/14] FRV: Make calibrate_delay() optional
Message-ID: <20041102093610.GB5841@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	dhowells@redhat.com, torvalds@osdl.org, akpm@osdl.org,
	davidm@snapgear.com, linux-kernel@vger.kernel.org,
	uclinux-dev@uclinux.org
References: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com> <200411011930.iA1JULKN023227@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411011930.iA1JULKN023227@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> + *  GK 2/5/95  -  Changed to support mounting root fs via NFS
> + *  Added initrd & change_root: Werner Almesberger & Hans Lermen, Feb '96
> + *  Moan early if gcc is old, avoiding bogus kernels - Paul Gortmaker, May '96
> + *  Simplified starting of init:  Michael A. Griffith <grif@acm.org> 

this changelog certainly does not apply to the delay loop calibration.

>  lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
>  	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
>  	 kobject.o kref.o idr.o div64.o parser.o int_sqrt.o \
> -	 bitmap.o extable.o kobject_uevent.o find_next_bit.o
> +	 bitmap.o extable.o kobject_uevent.o find_next_bit.o \
> +	 calibrate.o

any reason it's in lib?  Better move this to kernel and properly compile
it conditionally.


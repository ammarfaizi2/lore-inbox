Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbWCVHHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWCVHHB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 02:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbWCVHG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 02:06:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6860 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751003AbWCVHG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 02:06:58 -0500
Date: Tue, 21 Mar 2006 23:03:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC, PATCH] avoid some atomics in open()/close() for
 monothreaded processes
Message-Id: <20060321230335.0e7edcc7.akpm@osdl.org>
In-Reply-To: <4420F5BF.7030701@cosmosbay.com>
References: <20060315054416.GF3205@localhost.localdomain>
	<1142403500.26706.2.camel@sli10-desk.sh.intel.com>
	<20060314233138.009414b4.akpm@osdl.org>
	<4417E047.70907@cosmosbay.com>
	<441EFE05.8040506@cosmosbay.com>
	<4420DB55.60803@cosmosbay.com>
	<4420ED66.5060703@cosmosbay.com>
	<20060321224140.7e40a380.akpm@osdl.org>
	<4420F5BF.7030701@cosmosbay.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <dada1@cosmosbay.com> wrote:
>
> > 
>  > Once you're done with that we should change fget_light() and fput_light() to
>  > use this helper.  Separate patch.
> 
>  Hum... this discussion is not relevant with fget_light() unless I mistaken.

Take a look.  fget_light() uses essentially the same test as you do, for
the same reason.  So it's appropriate that fget_light() use this new helper
rather than open-coding it.

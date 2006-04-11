Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWDKXTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWDKXTN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 19:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWDKXTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 19:19:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32644 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751341AbWDKXTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 19:19:12 -0400
Date: Tue, 11 Apr 2006 16:21:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: kjhall@us.ibm.com, linux-kernel@vger.kernel.org,
       tpmdd-devel@lists.sourceforge.net
Subject: Re: [PATCH] tpm: use clear_bit
Message-Id: <20060411162125.660e5535.akpm@osdl.org>
In-Reply-To: <20060411160206.4bffa1c2.akpm@osdl.org>
References: <1144679828.4917.11.camel@localhost.localdomain>
	<20060410145030.0b719e18.akpm@osdl.org>
	<1144795345.12054.36.camel@localhost.localdomain>
	<20060411160206.4bffa1c2.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> -		dev_mask[i] &= !(1 << j);
> +		clear_bit(dev_num, dev_mask);

Note that this fixes a bug.  We wanted a ~ in there.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWEKSuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWEKSuT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 14:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWEKSuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 14:50:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55477 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932123AbWEKSuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 14:50:18 -0400
Date: Thu, 11 May 2006 11:52:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, hch@lst.de, bcrl@kvack.org,
       cel@citi.umich.edu
Subject: Re: [PATCH 1/4] Vectorize aio_read/aio_write methods
Message-Id: <20060511115251.5e008c5d.akpm@osdl.org>
In-Reply-To: <1147361939.12117.12.camel@dyn9047017100.beaverton.ibm.com>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com>
	<1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com>
	<1147361890.12117.11.camel@dyn9047017100.beaverton.ibm.com>
	<1147361939.12117.12.camel@dyn9047017100.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> +	size_t count = 0;
> +
> +	for (seg = 0; seg < nr_segs; seg++)
> +		count += iov[seg].iov_len;

We have iov_length() for this.  pls review all patches, send updates if
appropriate.


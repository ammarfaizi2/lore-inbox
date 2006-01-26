Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWAZHaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWAZHaU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 02:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbWAZHaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 02:30:19 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:58712 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750813AbWAZHaS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 02:30:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hYBkj/1PKYfGUKaioWSNdw9GTByOJcLNQC4XCs79YMYPgkjrL6PDJ2yAXxBnpN3J2rXvuhzaFTBBm8vhALZKSsstB3NpZzT5Q8a2xG+K4bb6OWhJgKWGIDJMA1PZ9pF+ujF9Ym4pcgFaxX7nD5jHBsAUHhLvMOaVAKYkxXZDByM=
Message-ID: <84144f020601252330k61789482m25a4316c2c254065@mail.gmail.com>
Date: Thu, 26 Jan 2006 09:30:16 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: colpatch@us.ibm.com
Subject: Re: [patch 6/9] mempool - Update kzalloc mempool users
Cc: linux-kernel@vger.kernel.org, sri@us.ibm.com, andrea@suse.de,
       pavel@suse.cz, linux-mm@kvack.org
In-Reply-To: <1138218014.2092.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060125161321.647368000@localhost.localdomain>
	 <1138218014.2092.6.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/25/06, Matthew Dobson <colpatch@us.ibm.com> wrote:
> plain text document attachment (critical_mempools)
> Fixup existing mempool users to use the new mempool API, part 3.
>
> This mempool users which are basically just wrappers around kzalloc().  To do
> this we create a new function, kzalloc_node() and change all the old mempool
> allocators which were calling kzalloc() to now call kzalloc_node().

The slab bits look good to me. You might have some rediffing to do
because -mm has quite a bit of slab patches in it.

Acked-by: Pekka Enberg <penberg@cs.helsinki.fi>

                               Pekka

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261823AbULJVkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbULJVkR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 16:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbULJVkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 16:40:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:23481 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261816AbULJVjw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 16:39:52 -0500
Date: Fri, 10 Dec 2004 13:38:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: clameter@sgi.com, torvalds@osdl.org, benh@kernel.crashing.org,
       nickpiggin@yahoo.com.au, linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: pfault V12 : correction to tasklist rss
Message-Id: <20041210133859.2443a856.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0412102054190.32422-100000@localhost.localdomain>
References: <Pine.LNX.4.58.0412101150490.9169@schroedinger.engr.sgi.com>
	<Pine.LNX.4.44.0412102054190.32422-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> > We have no  real way of establishing the ownership of shared pages
>  > anyways. Its counted when allocated. But the page may live on afterwards
>  > in another process and then not be accounted for although its only user is
>  > the new process.
> 
>  I didn't understand that bit.

We did lose some accounting accuracy when the pagetable walk and the big
tasklist walks were removed.  Bill would probably have more details.  Given
that the code as it stood was a complete showstopper, the tradeoff seemed
reasonable.

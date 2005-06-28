Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262102AbVF1QDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262102AbVF1QDe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 12:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbVF1QDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 12:03:34 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:30915 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262102AbVF1QDb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 12:03:31 -0400
Subject: Re: [patch 2] mm: speculative get_page
From: Dave Hansen <haveblue@us.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andy Whitcroft <apw@shadowen.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
In-Reply-To: <42C14D93.7090303@yahoo.com.au>
References: <42BF9CD1.2030102@yahoo.com.au> <42BF9D67.10509@yahoo.com.au>
	 <42BF9D86.90204@yahoo.com.au> <42C14662.40809@shadowen.org>
	 <42C14D93.7090303@yahoo.com.au>
Content-Type: text/plain
Date: Tue, 28 Jun 2005 09:02:46 -0700
Message-Id: <1119974566.14830.111.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-28 at 23:16 +1000, Nick Piggin wrote:
> I think there are a a few ways that bits can be reclaimed if we
> start digging. swsusp uses 2 which seems excessive though may be
> fully justified. 

They (swsusp) actually don't need the bits at all until suspend-time, at
all.  Somebody coded up a "dynamic page flags" patch that let them kill
the page->flags use, but it didn't really go anywhere.  Might be nice if
someone dug it up.  I probably have a copy somewhere.

-- Dave


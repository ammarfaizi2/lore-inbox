Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261984AbSJQUYC>; Thu, 17 Oct 2002 16:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262065AbSJQUYC>; Thu, 17 Oct 2002 16:24:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32702 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261984AbSJQUYA>;
	Thu, 17 Oct 2002 16:24:00 -0400
Date: Thu, 17 Oct 2002 13:22:29 -0700 (PDT)
Message-Id: <20021017.132229.107707607.davem@redhat.com>
To: eric@bartonsoftware.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel vaddr -> struct page
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200210171911.g9HJBHk02456@bartonsoftware.com>
References: <200210171911.g9HJBHk02456@bartonsoftware.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


vmalloc_to_page() does not work on kmalloc/kmap'd memory.

On many system kmalloc memory is not even represented in the
page tables because the mapping goes through a direct bypass
window.

You need to know where the object came from to convert it
into a page properly.  You should be allocating and passing
around pages internally anyways.

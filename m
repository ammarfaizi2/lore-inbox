Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbUDAQ3O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 11:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbUDAQ3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 11:29:14 -0500
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:13725 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S262960AbUDAQ3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 11:29:13 -0500
Message-ID: <406C43A4.E29F92FB@nospam.org>
Date: Thu, 01 Apr 2004 18:30:28 +0200
From: Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org>
Reply-To: Zoltan.Menyhart@bull.net
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: To kunmap_atomic or not to kunmap_atomic ?
References: <Pine.LNX.4.58.0404010734020.18465@build.arklinux.oregonstate.edu>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can see a couple of functions, like

static inline struct mm_struct * ptep_to_mm(pte_t * ptep)
{
	struct page * page = kmap_atomic_to_page(ptep);
	return (struct mm_struct *) page->mapping;
}

in "rmap.?" without invoking "kunmap_atomic()".
Is it intentional?
What if for an architecture "kunmap_atomic()" is not a no-op ?
Thanks,

Zoltan Menyhart

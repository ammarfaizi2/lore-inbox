Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbVEaJYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVEaJYB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 05:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261480AbVEaJYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 05:24:01 -0400
Received: from colin.muc.de ([193.149.48.1]:9992 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261412AbVEaJX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 05:23:59 -0400
Date: 31 May 2005 11:23:58 +0200
Date: Tue, 31 May 2005 11:23:58 +0200
From: Andi Kleen <ak@muc.de>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       Jeff Garzik <jgarzik@pobox.com>, Benjamin LaHaise <bcrl@kvack.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] x86-64: Use SSE for copy_page and clear_page
Message-ID: <20050531092358.GA9372@muc.de>
References: <20050530181626.GA10212@kvack.org> <20050530193225.GC25794@muc.de> <200505311137.00011.vda@ilport.com.ua> <200505311215.06495.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505311215.06495.vda@ilport.com.ua>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thus with "normal" page clear and "nt" page copy routines
> both clear and copy benchmarks run faster than with
> stock kernel, both with small and large working set.
> 
> Am I wrong?

fork is only a corner case. The main case is a process allocating
memory using brk/mmap and then using it.

-Andi

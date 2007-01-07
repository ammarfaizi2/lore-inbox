Return-Path: <linux-kernel-owner+w=401wt.eu-S932324AbXAGCGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbXAGCGV (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 21:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbXAGCGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 21:06:21 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:19158 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932324AbXAGCGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 21:06:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Sb27XaYko9aTZ1l9nxVViluM34UYq4JvWtJDxn/yKsVQkJwcmDaeazXiDy2HOled5ww76L0WYgjrSyZWnaOekL/2lb0KevAuZLLfNueFHVFZa7EfiDnzgxvY0zwLgUBsicGL3xiE9bsi2mno8KkGhwuTXS5NcoLd6LMTokDgOn0=
Message-ID: <cd32a0620701061806y719fcf8bwd61daf05dac1bc3c@mail.gmail.com>
Date: Sun, 7 Jan 2007 12:36:18 +1030
From: "Tom Lanyon" <tomlanyon@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Andrei Popa" <andrei.popa@i-neo.ro>,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
       "David S. Miller" <davem@davemloft.net>,
       "Andrew Morton" <akpm@osdl.org>,
       "Gordon Farquharson" <gordonfarquharson@gmail.com>,
       "Martin Michlmayr" <tbm@cyrius.com>, "Hugh Dickins" <hugh@veritas.com>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0612261007100.3671@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com>
	 <20061224005752.937493c8.akpm@osdl.org>
	 <1166962478.7442.0.camel@localhost>
	 <20061224043102.d152e5b4.akpm@osdl.org>
	 <1166978752.7022.1.camel@localhost>
	 <Pine.LNX.4.64.0612240907180.3671@woody.osdl.org>
	 <Pine.LNX.4.64.0612241029460.3671@woody.osdl.org>
	 <Pine.LNX.4.64.0612241115130.3671@woody.osdl.org>
	 <4590F9E5.4060300@yahoo.com.au>
	 <Pine.LNX.4.64.0612261007100.3671@woody.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/06, Linus Torvalds <torvalds@osdl.org> wrote:
> What would also actually be interesting is whether somebody can reproduce
> this on Reiserfs, for example. I _think_ all the reports I've seen are on
> ext2 or ext3, and if this is somehow writeback-related, it could be some
> bug that is just shared between the two by virtue of them still having a
> lot of stuff in common.
>
>                         Linus

I've been following this thread for a while now as I started
experiencing file corruption in rtorrent when I upgraded to 2.6.19. I
am using reiserfs.

-- 
Tom Lanyon

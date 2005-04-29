Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262909AbVD2Tpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262909AbVD2Tpt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 15:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbVD2Tpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 15:45:49 -0400
Received: from webmail.houseafrika.com ([12.162.17.52]:46464 "EHLO
	Mansi.STRATNET.NET") by vger.kernel.org with ESMTP id S262909AbVD2Tpk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 15:45:40 -0400
To: bjordan@infinicon.com
Cc: Caitlin Bestler <caitlin.bestler@gmail.com>, Andrew Morton <akpm@osdl.org>,
       hch@infradead.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org, Timur Tabi <timur.tabi@ammasso.com>
Subject: Re: RDMA memory registration
X-Message-Flag: Warning: May contain useful information
References: <20050425135401.65376ce0.akpm@osdl.org>
	<20050426084234.A10366@topspin.com> <52mzrlsflu.fsf@topspin.com>
	<20050426122850.44d06fa6.akpm@osdl.org> <5264y9s3bs.fsf@topspin.com>
	<426EA220.6010007@ammasso.com> <20050426133752.37d74805.akpm@osdl.org>
	<5ebee0d105042907265ff58a73@mail.gmail.com>
	<469958e005042908566f177b50@mail.gmail.com>
	<52d5sdjzup.fsf_-_@topspin.com>
	<5ebee0d1050429124333776354@mail.gmail.com>
From: Roland Dreier <roland@topspin.com>
Date: Fri, 29 Apr 2005 12:45:38 -0700
In-Reply-To: <5ebee0d1050429124333776354@mail.gmail.com> (Bill Jordan's
 message of "Fri, 29 Apr 2005 15:43:10 -0400")
Message-ID: <52ll71icyl.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 29 Apr 2005 19:45:38.0940 (UTC) FILETIME=[04FDCBC0:01C54CF4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bill> Are you suggesting making the partial pages their own VMA,
    Bill> or marking the entire buffer with this flag? I originally
    Bill> thought the entire buffer should be copy on fork (instead of
    Bill> copy on write), and I believe this is the path Mellanox was
    Bill> pursing with the VM_NO_COW flag.  However, if applications
    Bill> are registering gigs of ram, it would be very bad to have
    Bill> the entire area copied on fork.

It's up to userspace really but I would expect that the partial pages
would be in a vma by themselves.

 - R.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423603AbWJaUYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423603AbWJaUYK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 15:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423605AbWJaUYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 15:24:10 -0500
Received: from mail.parknet.jp ([210.171.160.80]:45064 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1423602AbWJaUYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 15:24:08 -0500
X-AuthUser: hirofumi@parknet.jp
To: "Holden Karau" <holden@pigscanfly.ca>
Cc: "Holden Karau" <holdenk@xandros.com>,
       "Josef Sipek" <jsipek@fsl.cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       "akpm\@osdl.org" <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       "Nick Piggin" <nickpiggin@yahoo.com.au>,
       =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Subject: Re: [PATCH 1/1] fat: improve sync performance by grouping writes revised
References: <454765AC.1050905@xandros.com>
	<87mz7cqvd8.fsf@duaron.myhome.or.jp>
	<f46018bb0610311046t6aa969ccy60a2020f7e5a0ed9@mail.gmail.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 01 Nov 2006 05:23:58 +0900
In-Reply-To: <f46018bb0610311046t6aa969ccy60a2020f7e5a0ed9@mail.gmail.com> (Holden Karau's message of "Tue\, 31 Oct 2006 13\:46\:46 -0500")
Message-ID: <87slh4tesh.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Holden Karau" <holden@pigscanfly.ca> writes:

> The performance increase is pretty small. Using an old external dirve
> I had lying around I got:
> diff -y stock/10k modified/10k
> 10240+0 records in                                            | 1024+0
> records in
> 10240+0 records out                                           | 1024+0
> records out
> 5242880 bytes transferred in 18.280922 seconds (286795 bytes/ | 524288
> bytes transferred in 1.824985 seconds (287283 bytes/se

1024 records out 1.824985 seconds. Is there decrease case?  I assume
the result is same. So, we would need different approach.

> diff -y stock/1k modified/1k
> 1024+0 records in                                               1024+0
> records in
> 1024+0 records out                                              1024+0
> records out
> 524288 bytes transferred in 1.777250 seconds (295000 bytes/se | 524288
> bytes transferred in 1.764748 seconds (297089 bytes/se
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265111AbSKNRpE>; Thu, 14 Nov 2002 12:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265114AbSKNRpE>; Thu, 14 Nov 2002 12:45:04 -0500
Received: from adsl-66-127-195-58.dsl.snfc21.pacbell.net ([66.127.195.58]:37263
	"EHLO panda.mostang.com") by vger.kernel.org with ESMTP
	id <S265111AbSKNRpC>; Thu, 14 Nov 2002 12:45:02 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] remove hugetlb syscalls
References: <Pine.LNX.4.44L.0211132239370.3817-100000@imladris.surriel.com> <08a601c28bbb$2f6182a0$760010ac@edumazet> <20021114141310.A25747@infradead.org>
From: David Mosberger-Tang <David.Mosberger@acm.org>
Date: 14 Nov 2002 09:51:55 -0800
In-Reply-To: <20021114141310.A25747@infradead.org>
Message-ID: <ugel9oavk4.fsf@panda.mostang.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 14 Nov 2002 15:20:10 +0100, Christoph Hellwig <hch@infradead.org> said:

  Christoph> mount -t hugetlbfs whocares /huge

  Christoph> fd = open("/huge/nose", ..)

  Christoph> mmap(.., fd, ..)

One potential downside of this is that programmers might expect
mremap(), mprotect() etc. to work on the returned memory at the
granularity of base-pages.  I'm not sure though whether that was part
of the reason Linus wanted separate syscalls.

	--david

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265255AbSKNVjd>; Thu, 14 Nov 2002 16:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265266AbSKNVjd>; Thu, 14 Nov 2002 16:39:33 -0500
Received: from adsl-66-127-195-58.dsl.snfc21.pacbell.net ([66.127.195.58]:20887
	"EHLO panda.mostang.com") by vger.kernel.org with ESMTP
	id <S265255AbSKNVjc>; Thu, 14 Nov 2002 16:39:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15828.6578.671944.358273@panda.mostang.com>
Date: Thu, 14 Nov 2002 13:46:26 -0800
To: William Lee Irwin III <wli@holomorphy.com>
Cc: David.Mosberger@acm.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] remove hugetlb syscalls
In-Reply-To: <20021114213822.GO23425@holomorphy.com>
References: <Pine.LNX.4.44L.0211132239370.3817-100000@imladris.surriel.com>
	<08a601c28bbb$2f6182a0$760010ac@edumazet>
	<20021114141310.A25747@infradead.org>
	<ugel9oavk4.fsf@panda.mostang.com>
	<20021114203411.GG22031@holomorphy.com>
	<15828.5673.94643.36160@panda.mostang.com>
	<20021114213822.GO23425@holomorphy.com>
X-Mailer: VM 7.03 under Emacs 21.2.1
Reply-To: David.Mosberger@acm.org
X-URL: http://www.mostang.com/~davidm/
From: davidm@mostang.com (David Mosberger-Tang)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 14 Nov 2002 13:38:22 -0800, William Lee Irwin III <wli@holomorphy.com> said:

  Bill> On Thu, 14 Nov 2002 12:34:11 -0800, William Lee Irwin III
  Bill> said:
  William> (3) ->f_op->mmap() will hand -EINVAL back to userspace
  William> instead of automatically placing the vma, for explicit and
  William> 0 start adresses

  Bill> On Thu, Nov 14, 2002 at 01:31:21PM -0800, David Mosberger-Tang
  Bill> wrote:
  >> This sounds like a receipe for creating unportable programs
  >> because the alignment constraints will be different from one
  >> platform to another.  (Adding gethugepagesize() in libc would
  >> alleviate the problem but it wouldn't solve it completely.)
  >> Overall, it does sound to me that the hugetlbfs is so specialized
  >> that it would be much cleaner to provide a separate interface at
  >> the user-level.  That would leave more flexibility should the
  >> implementation change over time (which it well might).  --david

  Bill> Okay, that's a serious problem. But it's easy to fix; I'll
  Bill> just call the hugepage vma placement functions that are also
  Bill> used by the syscalls.

Sounds good to me.

Thanks,

	--david

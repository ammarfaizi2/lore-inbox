Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282010AbRKZShl>; Mon, 26 Nov 2001 13:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282016AbRKZSgK>; Mon, 26 Nov 2001 13:36:10 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:24653 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S282027AbRKZSev>; Mon, 26 Nov 2001 13:34:51 -0500
Date: Mon, 26 Nov 2001 13:34:50 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Momchil Velikov <velco@fadata.bg>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] Scalable page cache
Message-ID: <20011126133450.C13955@redhat.com>
In-Reply-To: <20011126131641.A13955@redhat.com> <Pine.LNX.4.33.0111262115261.17043-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0111262115261.17043-100000@localhost.localdomain>; from mingo@elte.hu on Mon, Nov 26, 2001 at 09:29:39PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2001 at 09:29:39PM +0100, Ingo Molnar wrote:
> this is a misunderstanding of the problem. The reason why the
> pagecache_lock is a performance problem is *not* contention, the reason is
> *not* the length of chains, or any other reason you listed. The problem is
> SMP cacheline invalidation costs, due to using the same cacheline from
> multiple CPUs. Thus the spreading out of locking gives good SMP cacheline
> usage properties.

Please reply to the rest of the message.  Perhaps that item is a 
misunderstanding, but the rest of it is applicable across the board.

		-ben

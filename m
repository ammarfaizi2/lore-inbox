Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276534AbRJHRYH>; Mon, 8 Oct 2001 13:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276556AbRJHRX5>; Mon, 8 Oct 2001 13:23:57 -0400
Received: from are.twiddle.net ([64.81.246.98]:64931 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S276534AbRJHRXp>;
	Mon, 8 Oct 2001 13:23:45 -0400
Date: Mon, 8 Oct 2001 10:24:12 -0700
From: Richard Henderson <rth@twiddle.net>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 2.4.11-pre5] atomic_dec_and_lock() for alpha
Message-ID: <20011008102412.A24348@twiddle.net>
Mail-Followup-To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011008194257.A705@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011008194257.A705@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Mon, Oct 08, 2001 at 07:42:57PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2001 at 07:42:57PM +0400, Ivan Kokshaysky wrote:
> +	"	ret\n"

I am extremely uncomfortable with you returning out of the middle of
an asm statement.  What if the compiler decides to allocate a stack
frame for some reason?  You'll return without deallocating it.

Please write the whole thing in assembly or avoid the early return.


r~

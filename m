Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280554AbRKSSbr>; Mon, 19 Nov 2001 13:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280547AbRKSSbh>; Mon, 19 Nov 2001 13:31:37 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:25618 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S280538AbRKSSb0>; Mon, 19 Nov 2001 13:31:26 -0500
Date: Mon, 19 Nov 2001 12:31:25 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [VM] 2.4.14/15-pre4 too "swap-happy"?
Message-ID: <20011119123125.B1439@asooo.flowerfire.com>
In-Reply-To: <200111191801.fAJI1l922388@neosilicon.transmeta.com> <Pine.LNX.4.33.0111191003470.8205-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.33.0111191003470.8205-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Nov 19, 2001 at 10:07:58AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, so far 2.4.15-pre4 with your patch does not reproduce the kswapd
issue with Oracle, but I do need to perform more deterministic tests
before I can fully sign off on that.

BTW, didn't your patch go into -pre5?  Or is there an additional mod in
-pre6 that we should try?
-- 
Ken.
brownfld@irridia.com

On Mon, Nov 19, 2001 at 10:07:58AM -0800, Linus Torvalds wrote:
| 
| On Mon, 19 Nov 2001, Sebastian Dröge wrote:
| > Hi,
| > I couldn't answer ealier because I had some problems with my ISP
| > the heavy swapping problem while burning a cd is solved in pre6aa1
| > but if you want i can do some statistics tommorow
| 
| Well, pre6aa1 performs really badly exactly because it by default doesn't
| swap enough even on _normal_ loads because Andrea is playing with some
| tuning (and see the bad results of that tuning in the VM testing by
| rwhron@earthlink.net).
| 
| So the pre6aa1 numbers are kind of suspect - lack of swapping may not be
| due to fixing the problem, but due to bad tuning.
| 
| Does plain pre6 solve it? Plain pre6 has a fix where a locked shared
| memory area would previously cause unnecessary swapping, and maybe the CD
| burning buffer is using shmlock..
| 
| 		Linus
| 
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/

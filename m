Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274520AbRITOex>; Thu, 20 Sep 2001 10:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274521AbRITOed>; Thu, 20 Sep 2001 10:34:33 -0400
Received: from zeke.inet.com ([199.171.211.198]:48552 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S274520AbRITOe2>;
	Thu, 20 Sep 2001 10:34:28 -0400
Message-ID: <3BA9FE7D.912233AD@inet.com>
Date: Thu, 20 Sep 2001 09:34:37 -0500
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.19-6.2.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tobin Park <shinywind@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Network buffer allocation
In-Reply-To: <F177WQejqpRI7aIrq0400001a8c@hotmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tobin Park wrote:
> 
> Hello,
> I am a newbie of linux kernel and studying network kernel source.
> when network device driver receives packet and allocates buffer,
> what is the default size of allocation?
> and is there any reallocation happened when upper layer(ip/tcp) manipulates
> buffer which was allocated by device driver?

You like to jump in the deep end, I see.

You might want to look at LINUX IP Stacks Commentary by Satchell and
Clifford (Coriolis).  It covers 2.0, but it might prove helpful anyway.
(Also look into the device driver book, kernelnewbies.org, and the
like...)

I'm not sure about a default allocation size... I'm not sure if there is
one.

But as for the reallocation in the upper layers, usually it doesn't.  (I
think there are some cases where it may have to, but we want to avoid it
when we can.)  From my knowledge of 2.2.x, you'll want to look at how
that is avoided by using skb_push(), skb_pull(), skb_trim(),
skb_reserve(), etc.
skb_copy() and skb_clone() may also be of interest.

HTH, and good luck!

Eli 
--------------------.     Real Users find the one combination of bizarre
Eli Carter           \ input values that shuts down the system for days.
eli.carter(a)inet.com `-------------------------------------------------

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274292AbRIYAlp>; Mon, 24 Sep 2001 20:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274293AbRIYAlg>; Mon, 24 Sep 2001 20:41:36 -0400
Received: from myth7.Stanford.EDU ([171.64.15.21]:7351 "EHLO
	myth7.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S274292AbRIYAlb>; Mon, 24 Sep 2001 20:41:31 -0400
Date: Mon, 24 Sep 2001 17:41:44 -0700 (PDT)
From: Ken Ashcraft <kash@stanford.edu>
To: "David S. Miller" <davem@redhat.com>
cc: <linux-kernel@vger.kernel.org>, <mc@cs.Stanford.EDU>
Subject: Re: [CHECKER] two probable security holes
In-Reply-To: <20010924.172608.105430357.davem@redhat.com>
Message-ID: <Pine.GSO.4.31.0109241733010.17545-100000@myth7.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2001, David S. Miller wrote:
> ifreq copied safely to kernel space, ifr.ifr_name[] is inside the
> struct and NOT a user pointer.

Sorry, my explanation of the checker may not have been clear enough-- a
format string error does not occur because the kernel dereferences a user
pointer.  It happens because the format string to a printing function is
set by the user.  You are correct that ifr_name[] is not a user pointer,
but the contents of that array could contain dangerous placeholders set by
the user.  I hope that clears things up.

Ken


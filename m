Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274341AbRIYB1Q>; Mon, 24 Sep 2001 21:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274342AbRIYB1G>; Mon, 24 Sep 2001 21:27:06 -0400
Received: from pizda.ninka.net ([216.101.162.242]:61834 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S274341AbRIYB0x>;
	Mon, 24 Sep 2001 21:26:53 -0400
Date: Mon, 24 Sep 2001 18:27:14 -0700 (PDT)
Message-Id: <20010924.182714.35014075.davem@redhat.com>
To: kash@Stanford.EDU
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
Subject: Re: [CHECKER] two probable security holes
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.GSO.4.31.0109241733010.17545-100000@myth7.Stanford.EDU>
In-Reply-To: <20010924.172608.105430357.davem@redhat.com>
	<Pine.GSO.4.31.0109241733010.17545-100000@myth7.Stanford.EDU>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ken Ashcraft <kash@Stanford.EDU>
   Date: Mon, 24 Sep 2001 17:41:44 -0700 (PDT)
   
   It happens because the format string to a printing function is
   set by the user.  You are correct that ifr_name[] is not a user pointer,
   but the contents of that array could contain dangerous placeholders set by
   the user.  I hope that clears things up.

I see... luckily these are (as far as I can tell) all root-only
operations.

Ok, it's pretty easy to add a quick verifier to dev_alloc_name, I'll
code that up.

Franks a lot,
David S. Miller
davem@redhat.com

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314138AbSIALhI>; Sun, 1 Sep 2002 07:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314396AbSIALhH>; Sun, 1 Sep 2002 07:37:07 -0400
Received: from pizda.ninka.net ([216.101.162.242]:11458 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S314138AbSIALhH>;
	Sun, 1 Sep 2002 07:37:07 -0400
Date: Sun, 01 Sep 2002 04:35:12 -0700 (PDT)
Message-Id: <20020901.043512.51698754.davem@redhat.com>
To: szepe@pinerecords.com
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] warnkill trivia 2/2
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020901113741.GM32122@louise.pinerecords.com>
References: <20020901112856.GL32122@louise.pinerecords.com>
	<20020901.042539.63049493.davem@redhat.com>
	<20020901113741.GM32122@louise.pinerecords.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Tomas Szepe <szepe@pinerecords.com>
   Date: Sun, 1 Sep 2002 13:37:42 +0200

   > BTW who even passes around const atomic_t's?  Ie. what
   > genrated the warning and made you even edit this to begin with?
   
   fs/reiserfs/buffer2.c, line ~28:
   atomic_t gets the const quality on account of being a member
   of a const struct buffer_head instance.
   
   void wait_buffer_until_released (const struct buffer_head * bh)
   {

Reiserfs is buggy, it means struct  buffer_head const * bh

Let's keep the sparc atomic_read() how it is so more bugs
like this can be found.

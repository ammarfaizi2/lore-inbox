Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318455AbSH1AoE>; Tue, 27 Aug 2002 20:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318458AbSH1AoE>; Tue, 27 Aug 2002 20:44:04 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32403 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318455AbSH1AoD>;
	Tue, 27 Aug 2002 20:44:03 -0400
Date: Tue, 27 Aug 2002 17:42:44 -0700 (PDT)
Message-Id: <20020827.174244.24647029.davem@redhat.com>
To: s.biggs@softier.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug in kernel code?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D6BB999.5183.3D4AB9@localhost>
References: <3D6BB7CA.26619.363BFC@localhost>
	<20020827.172924.107290535.davem@redhat.com>
	<3D6BB999.5183.3D4AB9@localhost>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Stephen C. Biggs" <s.biggs@softier.com>
   Date: Tue, 27 Aug 2002 17:40:41 -0700
   
   You're misunderstanding me, I meant that the  first test is done
   AFTER the first iteration is   executed, so my fix is correct
   since, even if order is 0 because at least one iteration of the
   loop  is done, and the post decrement makes sure that the test
   succeeds if order was 0 going into the loop.

Order is always >= 0 when we enter the loop.

If we actually get the table allocated then the decrement of 'order'
is not executed if we allocate the table successfully.

I don't understand what the problem is with my fix.


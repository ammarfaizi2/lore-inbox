Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318310AbSHEFwR>; Mon, 5 Aug 2002 01:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318312AbSHEFwR>; Mon, 5 Aug 2002 01:52:17 -0400
Received: from pizda.ninka.net ([216.101.162.242]:29375 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318310AbSHEFwQ>;
	Mon, 5 Aug 2002 01:52:16 -0400
Date: Sun, 04 Aug 2002 22:42:20 -0700 (PDT)
Message-Id: <20020804.224220.41027416.davem@redhat.com>
To: torvalds@transmeta.com
Cc: akpm@zip.com.au, frankeh@watson.ibm.com, davidm@hpl.hp.com,
       davidm@napali.hpl.hp.com, gh@us.ibm.com, Martin.Bligh@us.ibm.com,
       wli@holomorpy.com, linux-kernel@vger.kernel.org
Subject: Re: large page patch (fwd) (fwd)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0208041225180.10314-100000@home.transmeta.com>
References: <3D4D7F24.10AC4BDB@zip.com.au>
	<Pine.LNX.4.44.0208041225180.10314-100000@home.transmeta.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Sun, 4 Aug 2002 12:28:54 -0700 (PDT)
   
   I suspect that there is some non-zero order-X (probably 2 or 3), where you 
   just win more than you lose. Even for small programs. 

Furthermore it would obviously help to enhance the clear_user_page()
interface to handle multiple pages because that would nullify the
startup/finish overhead of the copy loop.  (read as: things like TLB
loads and FPU save/restore on some platforms)

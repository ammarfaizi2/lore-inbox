Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263067AbSJGOZe>; Mon, 7 Oct 2002 10:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263068AbSJGOZe>; Mon, 7 Oct 2002 10:25:34 -0400
Received: from pizda.ninka.net ([216.101.162.242]:45977 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263067AbSJGOZe>;
	Mon, 7 Oct 2002 10:25:34 -0400
Date: Mon, 07 Oct 2002 07:24:26 -0700 (PDT)
Message-Id: <20021007.072426.93474936.davem@redhat.com>
To: kai-germaschewski@uiowa.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild news
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0210070919330.14294-100000@chaos.physics.uiowa.edu>
References: <20021007.010843.130618724.davem@redhat.com>
	<Pine.LNX.4.44.0210070919330.14294-100000@chaos.physics.uiowa.edu>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
   Date: Mon, 7 Oct 2002 09:22:51 -0500 (CDT)
   
   I'll take a look on how to do sparc's btfixup in a similar way, without 
   messing up the common code too much. BTW, the combination kallsyms +
   btfixup, does that need a particular ordering?

No, the kallsyms object file would not need to be seen by
the btfixup.o generator.  It could therefore be done validly
as:

	1) build .tmp_vmlinux
	2) build btfixup.o
	3) build kallsyms
	4) link final vmlinux image

The order of #2 and #3 could be transposed and that would be fine too.

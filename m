Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263286AbSIPWui>; Mon, 16 Sep 2002 18:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263288AbSIPWui>; Mon, 16 Sep 2002 18:50:38 -0400
Received: from pizda.ninka.net ([216.101.162.242]:65255 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263286AbSIPWug>;
	Mon, 16 Sep 2002 18:50:36 -0400
Date: Mon, 16 Sep 2002 15:46:40 -0700 (PDT)
Message-Id: <20020916.154640.78359545.davem@redhat.com>
To: dwmw2@infradead.org
Cc: linux-kernel@vger.kernel.org, todd-lkml@osogrande.com, hadi@cyberus.ca,
       tcw@tempest.prismnet.com, netdev@oss.sgi.com, pfeather@cs.unm.edu
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <12116.1032216780@redhat.com>
References: <20020916.125211.82482173.davem@redhat.com>
	<Pine.LNX.4.44.0209161528140.13850-100000@gp.staff.osogrande.com>
	<12116.1032216780@redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Woodhouse <dwmw2@infradead.org>
   Date: Mon, 16 Sep 2002 23:53:00 +0100
   
   Er, surely the same goes for sys_sendfile? Why have a new system call 
   rather than just swapping the 'in' and 'out' fds?

There is an assumption that one is a linear stream of output (in this
case a socket) and the other one is a page cache based file.

It would be nice to extend sys_sendfile to work properly in both
ways in a manner that Linus would accept, want to work on that?

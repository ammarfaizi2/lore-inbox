Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314149AbSDLVjc>; Fri, 12 Apr 2002 17:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314150AbSDLVjc>; Fri, 12 Apr 2002 17:39:32 -0400
Received: from pizda.ninka.net ([216.101.162.242]:35556 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S314149AbSDLVjb>;
	Fri, 12 Apr 2002 17:39:31 -0400
Date: Fri, 12 Apr 2002 14:31:50 -0700 (PDT)
Message-Id: <20020412.143150.74519563.davem@redhat.com>
To: lk@tantalophile.demon.co.uk
Cc: ak@suse.de, taka@valinux.co.jp, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020412222252.A25184@kushida.apsleyroad.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jamie Lokier <lk@tantalophile.demon.co.uk>
   Date: Fri, 12 Apr 2002 22:22:52 +0100
   
   I'm not advocating more locking in read() -- there's no need, and it is
   quite important that it is fast!  But I would very much appreciate an
   understanding of the rules that relate reading, writing and truncating
   processes.  How much ordering & atomicity can I depend on?  Anything at all?

Basically none it appears :-)

If you need to depend upon a consistent snapshot of what some other
thread writes into a file, you must have some locking protocol to use
to synchronize with that other thread.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312573AbSDOBap>; Sun, 14 Apr 2002 21:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312574AbSDOBan>; Sun, 14 Apr 2002 21:30:43 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:15377 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S312573AbSDOBam>;
	Sun, 14 Apr 2002 21:30:42 -0400
Date: Mon, 15 Apr 2002 10:30:13 +0900 (JST)
Message-Id: <20020415.103013.62679757.taka@valinux.co.jp>
To: davem@redhat.com
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20020412.143934.33012005.davem@redhat.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, David

If you don't mind, could you give me some advises about
the sendpage mechanism.

I'd like to implenent sendpage of UDP stack which NFS uses heavily.
It may improve the performance of NFS over UDP dramastically.

I wonder if there were "SENDPAGES" interface instead of sendpage 
between socket layer and inet layer, we could send some pages
atomically with low overhead.
And it could make implementing RPC over UDP easier
to send multiple pages as one UDP pakcet easily.

How do you think about this approach?

davem>    I don't see it as a big problem and would just leave it as it is
davem>    (for NFS and local) 
davem> 
davem> I agree with Andi.  You can basically throw away my whole argument
davem> about this.  Applications that require synchonization between the
davem> writer of file contents and reader of file contents must do some
davem> kind of locking amongst themselves at user level.

OK.

Regards,
Hirokazu Takahashi


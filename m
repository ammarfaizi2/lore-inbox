Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288195AbSACEPM>; Wed, 2 Jan 2002 23:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288194AbSACEPC>; Wed, 2 Jan 2002 23:15:02 -0500
Received: from pizda.ninka.net ([216.101.162.242]:14208 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S288192AbSACEOn>;
	Wed, 2 Jan 2002 23:14:43 -0500
Date: Wed, 02 Jan 2002 20:13:52 -0800 (PST)
Message-Id: <20020102.201352.104034173.davem@redhat.com>
To: kernel@Expansa.sns.it
Cc: Nikita@Namesys.COM, linux-kernel@vger.kernel.org,
        Reiserfs-List@Namesys.COM
Subject: Re: reiserfs does not work with linux 2.4.17 on sparc64 CPUs
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0112281058130.30085-100000@Expansa.sns.it>
In-Reply-To: <15403.16930.233614.432899@laputa.namesys.com>
	<Pine.LNX.4.33.0112281058130.30085-100000@Expansa.sns.it>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Luigi Genoni <kernel@Expansa.sns.it>
   Date: Fri, 28 Dec 2001 11:03:27 +0100 (CET)

   OK, here is my oops
   
   reiserfs: checking transaction log (device 08:14) ...
   Using r5 hash to sort names
   Unsupported unaligned load/store trap for kernel at <000000000059bae8>.

Looks like some change in reiserfs in 2.4.17 has caused it to start
doing {set,clear,change}_bit() operations on pointers which are not
"long" aligned.

Franks a lot,
David S. Miller
davem@redhat.com

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290535AbSAQXki>; Thu, 17 Jan 2002 18:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290534AbSAQXkQ>; Thu, 17 Jan 2002 18:40:16 -0500
Received: from pizda.ninka.net ([216.101.162.242]:23693 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290535AbSAQXkL>;
	Thu, 17 Jan 2002 18:40:11 -0500
Date: Thu, 17 Jan 2002 15:38:59 -0800 (PST)
Message-Id: <20020117.153859.26929091.davem@redhat.com>
To: balbir_soni@hotmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Suspected bug in getpeername and getsockname
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <F79oay0q0NTY9agv3Su00012f71@hotmail.com>
In-Reply-To: <F79oay0q0NTY9agv3Su00012f71@hotmail.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Balbir Singh" <balbir_soni@hotmail.com>
   Date: Thu, 17 Jan 2002 15:35:59 -0800

   
   >From: "David S. Miller" <davem@redhat.com>
   >Optimizing error cases never bears any fruit.
   
   In this case, I certainly think it does. Could u give a
   case as to why doing this would be harmful? I think the
   only issue can be maintainability and doing the change
   cleanly. But I think u are a good maintainer and will
   accept the changes only if they are properly fixed.
   Right :-)

If I give up the maintainability (ie. make the code more error prone
due to duplication) I better be getting something back.

Can the user eat up more than a scheduling quantum because of the
work done by ->getname()?  I certainly don't think you can prove
this.

Since the user can't, there is no real gain from the change, only
negative maintainability aspects.  (and perhaps that it would make
you happy)

It certainly isn't work the long discussion we're having about it,
that is for sure.

You want this to make your broken getname() protocol semantics work
and I'd like you to address that instead.  I get the feeling that
you've designed this weird behavior and that it is not specified in
any standard anyways that your protocol must behave in this way.  I
suggest you change it to work without the user length being
available.

Franks a lot,
David S. Miller
davem@redhat.com

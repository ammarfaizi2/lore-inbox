Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313113AbSDSWFb>; Fri, 19 Apr 2002 18:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313114AbSDSWFa>; Fri, 19 Apr 2002 18:05:30 -0400
Received: from pizda.ninka.net ([216.101.162.242]:19131 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S313113AbSDSWFa>;
	Fri, 19 Apr 2002 18:05:30 -0400
Date: Fri, 19 Apr 2002 14:56:51 -0700 (PDT)
Message-Id: <20020419.145651.82832824.davem@redhat.com>
To: greearb@candelatech.com
Cc: rddunlap@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: unresolved symbol: __udivdi3
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3CC092F2.8090009@candelatech.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   From: Ben Greear <greearb@candelatech.com>
   Date: Fri, 19 Apr 2002 14:58:10 -0700

   then I get another unresolved symbol:
   __umodi3
   
Someone needs to add this routine under arch/sparc/lib/

   I'm guessing that there is some optimization the compiler is doing that
   is using the mod operator somehow, but I am unsure about how to work around
   this.

"guessing"?  Have a look the definition of do_div in asm-sparc/div64.h
it explicitly does a mod operation :-)

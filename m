Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261432AbSIWVY4>; Mon, 23 Sep 2002 17:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261426AbSIWVY3>; Mon, 23 Sep 2002 17:24:29 -0400
Received: from pizda.ninka.net ([216.101.162.242]:46523 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261368AbSIWVXq>;
	Mon, 23 Sep 2002 17:23:46 -0400
Date: Mon, 23 Sep 2002 14:17:52 -0700 (PDT)
Message-Id: <20020923.141752.91362457.davem@redhat.com>
To: davidm@hpl.hp.com, davidm@napali.hpl.hp.com
Cc: dmo@osdl.org, axboe@suse.de, phillips@arcor.de, _deepfire@mail.ru,
       linux-kernel@vger.kernel.org
Subject: Re: DAC960 in 2.5.38, with new changes
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15759.34428.608321.969391@napali.hpl.hp.com>
References: <15759.32569.964762.776074@napali.hpl.hp.com>
	<20020923.135708.10698522.davem@redhat.com>
	<15759.34428.608321.969391@napali.hpl.hp.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@napali.hpl.hp.com>
   Date: Mon, 23 Sep 2002 14:24:12 -0700

     >> I don't think the proposed 32-bit behavior is off the mark, and
     >> anyways x86 can actually make the 64-bit store I believe if it
     >> wants at least on more recent processors.
   
   Surely we wouldn't want to define a new API that can't be supported on
   all 32-bit platforms, no?  Perhaps writeq_nonatomic()?
   
I'm saying we define writeq() to be implementable as two 32-bit
transations, that will be the API.

I think adding some weird new writeq_nonatomic() will just create
more confusion than it saves.

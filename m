Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261451AbSIWVeQ>; Mon, 23 Sep 2002 17:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261454AbSIWVeQ>; Mon, 23 Sep 2002 17:34:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:53691 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261451AbSIWVeP>;
	Mon, 23 Sep 2002 17:34:15 -0400
Date: Mon, 23 Sep 2002 14:28:21 -0700 (PDT)
Message-Id: <20020923.142821.50184745.davem@redhat.com>
To: davidm@hpl.hp.com, davidm@napali.hpl.hp.com
Cc: phillips@arcor.de, dmo@osdl.org, axboe@suse.de, _deepfire@mail.ru,
       linux-kernel@vger.kernel.org
Subject: Re: DAC960 in 2.5.38, with new changes
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15759.35002.179075.973994@napali.hpl.hp.com>
References: <15759.34428.608321.969391@napali.hpl.hp.com>
	<E17tanS-0003cl-00@starship>
	<15759.35002.179075.973994@napali.hpl.hp.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@napali.hpl.hp.com>
   Date: Mon, 23 Sep 2002 14:33:46 -0700

   >>>>> On Mon, 23 Sep 2002 23:31:13 +0200, Daniel Phillips <phillips@arcor.de> said:
   
     Daniel> Why attempt to write 8 bytes on ia32 when only 4 are needed?
   
   Even on ia32 you'll need 8 bytes if the controller is operated in DAC
   mode (which is what you want for a machine with >4GB of memory), no?
   
Right.  But if we know the top 32-bits will always be zero (f.e. if
CONFIG_HIGHMEM is disabled on x86) one might want to optimize this
to avoid the first 32-bit store.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316541AbSIDXvM>; Wed, 4 Sep 2002 19:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316545AbSIDXvL>; Wed, 4 Sep 2002 19:51:11 -0400
Received: from pizda.ninka.net ([216.101.162.242]:51426 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316541AbSIDXvD>;
	Wed, 4 Sep 2002 19:51:03 -0400
Date: Wed, 04 Sep 2002 16:48:08 -0700 (PDT)
Message-Id: <20020904.164808.00001963.davem@redhat.com>
To: paulus@au1.ibm.com
Cc: alan@lxorguk.ukuu.org.uk, jamagallon@able.es, r.post@sara.nl,
       morten.helgesen@nextframe.net, linux-kernel@vger.kernel.org
Subject: Re: writing OOPS/panic info to nvram?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15734.39068.766611.169333@argo.ozlabs.ibm.com>
References: <20020904140856.GA1949@werewolf.able.es>
	<1031149539.2788.120.camel@irongate.swansea.linux.org.uk>
	<15734.39068.766611.169333@argo.ozlabs.ibm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Paul Mackerras <paulus@au1.ibm.com>
   Date: Thu, 5 Sep 2002 09:34:52 +1000 (EST)
   
   I believe SCSI defeated him. :)

If you can get at the interrupt handler, and the interrupt handler is
coded well enough to handle sharing interrupts (%99 of PCI scsi
drivers are) then it is doable.  Just submit it as normal through
scsi, mark it high priority somehow, and then keep calling the
interrupt handler in a loop until your command completes or fails :-)

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264918AbSIRCKy>; Tue, 17 Sep 2002 22:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264994AbSIRCKy>; Tue, 17 Sep 2002 22:10:54 -0400
Received: from pizda.ninka.net ([216.101.162.242]:646 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264918AbSIRCKx>;
	Tue, 17 Sep 2002 22:10:53 -0400
Date: Tue, 17 Sep 2002 19:06:41 -0700 (PDT)
Message-Id: <20020917.190641.84134530.davem@redhat.com>
To: jgarzik@mandrakesoft.com
Cc: akpm@digeo.com, manfred@colorfullife.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Info: NAPI performance at "low" loads
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D87E0C2.6040004@mandrakesoft.com>
References: <3D87A4A2.6050403@mandrakesoft.com>
	<20020917.144911.43656989.davem@redhat.com>
	<3D87E0C2.6040004@mandrakesoft.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jeff Garzik <jgarzik@mandrakesoft.com>
   Date: Tue, 17 Sep 2002 22:11:14 -0400
   
   You're looking at at least one extra get-irq-status too, at least in the 
   classical 10/100 drivers I'm used to seeing...
   
How so?  The number of ones done in the e1000 NAPI code are the same
(read register until no interesting status bits remain set, same as
pre-NAPI e1000 driver).

For tg3 it's a cheap memory read from the status block not a PIO.

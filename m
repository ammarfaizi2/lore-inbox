Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318767AbSIKN2Z>; Wed, 11 Sep 2002 09:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318768AbSIKN2Z>; Wed, 11 Sep 2002 09:28:25 -0400
Received: from pizda.ninka.net ([216.101.162.242]:49842 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318767AbSIKN2Y>;
	Wed, 11 Sep 2002 09:28:24 -0400
Date: Wed, 11 Sep 2002 06:25:10 -0700 (PDT)
Message-Id: <20020911.062510.00773243.davem@redhat.com>
To: jgarzik@mandrakesoft.com
Cc: steve@neptune.ca, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre6 tg3 compile errors
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D7EAC65.8030101@mandrakesoft.com>
References: <Pine.LNX.4.44.0209102218460.3875-100000@triton.neptune.on.ca>
	<3D7EAC65.8030101@mandrakesoft.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jeff Garzik <jgarzik@mandrakesoft.com>
   Date: Tue, 10 Sep 2002 22:37:25 -0400
   
   Wrap this line of code inside a
   
   #if TG3_VLAN_TAG_USED
   ...line 4881 here...
   #endif
   
Not sufficient, you need to have an "#else" clause that
sets RX_MODE_KEEP_VLAN_TAG all the time.

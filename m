Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318166AbSIFGyd>; Fri, 6 Sep 2002 02:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318369AbSIFGyd>; Fri, 6 Sep 2002 02:54:33 -0400
Received: from pizda.ninka.net ([216.101.162.242]:59779 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318166AbSIFGyc>;
	Fri, 6 Sep 2002 02:54:32 -0400
Date: Thu, 05 Sep 2002 23:51:59 -0700 (PDT)
Message-Id: <20020905.235159.128049953.davem@redhat.com>
To: Martin.Bligh@us.ibm.com
Cc: hadi@cyberus.ca, tcw@tempest.prismnet.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, niv@us.ibm.com
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <18563262.1031269721@[10.10.2.3]>
References: <20020905.204721.49430679.davem@redhat.com>
	<18563262.1031269721@[10.10.2.3]>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
   Date: Thu, 05 Sep 2002 23:48:42 -0700
   
   Just to throw another firework into the fire whilst people are 
   awake, NAPI does not seem to scale to this sort of load, which
   was disappointing, as we were hoping it would solve some of 
   our interrupt load problems ...

Stupid question, are you sure you have CONFIG_E1000_NAPI enabled?

NAPI is also not the panacea to all problems in the world.

I bet your greatest gain would be obtained from going to Tux
and using appropriate IRQ affinity settings and making sure
Tux threads bind to same cpu as device where they accept
connections.

It is standard method to obtain peak specweb performance.

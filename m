Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318933AbSICVXN>; Tue, 3 Sep 2002 17:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318943AbSICVXN>; Tue, 3 Sep 2002 17:23:13 -0400
Received: from pizda.ninka.net ([216.101.162.242]:46551 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318933AbSICVXM>;
	Tue, 3 Sep 2002 17:23:12 -0400
Date: Tue, 03 Sep 2002 14:20:28 -0700 (PDT)
Message-Id: <20020903.142028.00083689.davem@redhat.com>
To: kuznet@ms2.inr.ac.ru
Cc: taka@valinux.co.jp, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: TCP Segmentation Offloading (TSO)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020903.140555.51297783.davem@redhat.com>
References: <20020903.220302.26270018.taka@valinux.co.jp>
	<200209031322.RAA02182@sex.inr.ac.ru>
	<20020903.140555.51297783.davem@redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "David S. Miller" <davem@redhat.com>
   Date: Tue, 03 Sep 2002 14:05:55 -0700 (PDT)
   
   Better fix is to verify len >=2 before half-word alignment
   test at the beginning of csum_partial.  I am not enough of
   an x86 coder to hack this up reliably. :-)

Further inspection shows that PII/PPRO csum_partial variant requires
even more surgery and is even more outside my realm of x86 asm
capability :-)

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318765AbSICLcA>; Tue, 3 Sep 2002 07:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318760AbSICLcA>; Tue, 3 Sep 2002 07:32:00 -0400
Received: from pizda.ninka.net ([216.101.162.242]:61907 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318758AbSICLcA>;
	Tue, 3 Sep 2002 07:32:00 -0400
Date: Tue, 03 Sep 2002 04:29:09 -0700 (PDT)
Message-Id: <20020903.042909.29814101.davem@redhat.com>
To: paulus@samba.org
Cc: taka@valinux.co.jp, kuznet@ms2.inr.ac.ru, scott.feldman@intel.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       haveblue@us.ibm.com, Manand@us.ibm.com, christopher.leech@intel.com
Subject: Re: TCP Segmentation Offloading (TSO)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15732.40127.600622.881235@argo.ozlabs.ibm.com>
References: <20020903.164243.21934772.taka@valinux.co.jp>
	<20020903.005119.50342945.davem@redhat.com>
	<15732.40127.600622.881235@argo.ozlabs.ibm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Paul Mackerras <paulus@samba.org>
   Date: Tue, 3 Sep 2002 21:27:59 +1000 (EST)
   
   I notice though that if the length is odd, we (PPC) put the last byte
   in the left-hand (most significant) byte of a 16-bit halfword, with
   zero in the other byte, and add it in, whereas i386 puts the last byte
   in the least-significant position.

What PPC does is correct for big endian.

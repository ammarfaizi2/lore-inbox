Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318771AbSICNVQ>; Tue, 3 Sep 2002 09:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318778AbSICNVQ>; Tue, 3 Sep 2002 09:21:16 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:269 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S318771AbSICNVO>;
	Tue, 3 Sep 2002 09:21:14 -0400
Date: Tue, 03 Sep 2002 22:19:08 +0900 (JST)
Message-Id: <20020903.221908.84979146.taka@valinux.co.jp>
To: kuznet@ms2.inr.ac.ru
Cc: scott.feldman@intel.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, haveblue@us.ibm.com, Manand@us.ibm.com,
       davem@redhat.com, christopher.leech@intel.com
Subject: Re: TCP Segmentation Offloading (TSO)
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20020903.220302.26270018.taka@valinux.co.jp>
References: <20020903.164243.21934772.taka@valinux.co.jp>
	<200209031221.QAA01882@sex.inr.ac.ru>
	<20020903.220302.26270018.taka@valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Skb may have some pages in its skb_shared_info as frags, but each
> page may not have extra space in it while csum_partial() is used
> to compute checksum against each page.
> 
> We can see skb_checksum() calls csum_partial() againt each page in skb.
> No one knows whether the next page exits or not as it may be mapped
> in kmap space.

It's sad that it happened on my machine.
And Oops said csum_partial() tried to accesse the next page which was not
kmapped yet.


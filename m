Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289923AbSAKMSU>; Fri, 11 Jan 2002 07:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289926AbSAKMSK>; Fri, 11 Jan 2002 07:18:10 -0500
Received: from pizda.ninka.net ([216.101.162.242]:43905 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289923AbSAKMSD>;
	Fri, 11 Jan 2002 07:18:03 -0500
Date: Fri, 11 Jan 2002 04:17:08 -0800 (PST)
Message-Id: <20020111.041708.75430965.davem@redhat.com>
To: anders.vedmar@interactiveinstitute.se
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 raid5 checksumming function selection wierdness
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200201111208.g0BC8wI29387@nav.interactiveinstitute.se>
In-Reply-To: <200201111208.g0BC8wI29387@nav.interactiveinstitute.se>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Anders Vedmar <anders.vedmar@interactiveinstitute.se>
   Date: Fri, 11 Jan 2002 13:12:53 +0100

   The raid5 code in 2.4.17 seems to select the slowest available
   checksumming function.
   
It does so because: 1) It performs better for the cache miss
case and 2) it is more cache friendly

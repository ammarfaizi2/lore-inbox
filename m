Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261816AbTCaTAD>; Mon, 31 Mar 2003 14:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261818AbTCaTAD>; Mon, 31 Mar 2003 14:00:03 -0500
Received: from pizda.ninka.net ([216.101.162.242]:11393 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261816AbTCaTAB>;
	Mon, 31 Mar 2003 14:00:01 -0500
Date: Mon, 31 Mar 2003 11:05:51 -0800 (PST)
Message-Id: <20030331.110551.14104246.davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: kuznet@ms2.inr.ac.ru, netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       usagi@linux-ipv6.org, pioppo@ferrara.linux.it
Subject: Re: [PATCH] IPv6: Don't assign a same IPv6 address on a same
 interface
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030331.103451.118020141.yoshfuji@linux-ipv6.org>
References: <20030330163656.GA18645@ferrara.linux.it>
	<20030331.033524.114862210.yoshfuji@linux-ipv6.org>
	<20030331.103451.118020141.yoshfuji@linux-ipv6.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org>
   Date: Mon, 31 Mar 2003 10:34:51 +0900 (JST)

   In article <20030331.033524.114862210.yoshfuji@linux-ipv6.org> (at Mon, 31 Mar 2003 03:35:24 +0900 (JST)), YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> says:
   
   > In article <20030330163656.GA18645@ferrara.linux.it> (at Sun, 30 Mar 2003 18:36:56 +0200), Simone Piunno <pioppo@ferrara.linux.it> says:
   > 
   > >  - locking inside ipv6_add_addr() is simpler and more linear but
   > >    semantically wrong because you're unable to tell the user why his 
   > >    "ip addr add" failed.  E.g. you answer ENOBUFS instead of EEXIST.
   > 
   > We don't want to create duplicate address in any case.
   > ipv6_add_addr() IS right place.
   > And, we can return error code by using IS_ERR() etc.
   > I'll fix this.
   
   Here's the revised patch.

Applied to both 2.4.x and 2.5.x.

BTW, 2.4.x patch failed in two spots, one was author comment
which I easily fixed, second was in privacy code which I did not
apply yet to 2.4.x (I fixed this too, don't worry).

I do not want to put privacy code into 2.4.x until crypto is there.
I plan to put crypto lib into 2.4.22-pre1.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278031AbRJIWjf>; Tue, 9 Oct 2001 18:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278035AbRJIWjZ>; Tue, 9 Oct 2001 18:39:25 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24966 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S278031AbRJIWjJ>;
	Tue, 9 Oct 2001 18:39:09 -0400
Date: Tue, 09 Oct 2001 15:37:46 -0700 (PDT)
Message-Id: <20011009.153746.59466398.davem@redhat.com>
To: balbir.singh@wipro.com
Cc: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Trivial patch for SIOCGIFCOUNT
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3BC2FA63.6070006@wipro.com>
In-Reply-To: <3BC2FA63.6070006@wipro.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "BALBIR SINGH" <balbir.singh@wipro.com>
   Date: Tue, 09 Oct 2001 18:53:47 +0530

   	To make the API orthogonal, I have included a patch for SIOCGIFCOUNT,
   which currently returns -EINVAL. The only reason I am providing this patch
   is to make the API complete and make it easier to port applications from
   other UNIX like OS'es.

There is no need for this change, and _EVEN_ if we put this
change in today every APP out there would _STILL_ need to deal with
all existing kernels which do not have SIOCGIFCOUNT implemented.

Furthermore, SIOCGIFCOUNT also gives no new functionality that does
not exist already.  SIOCGIFCONF with a zero size with give the
behavior necessary to get the same answer as a SIOCGIFCOUNT would
provide.  As far as I am aware, every system providing BSD sockets
provides this SIOCGIFCONF "feature".

Therefore, it is already quite easy to make applications portable
between Linux and other BSD socket based systems.  Simply use the
SIOCGIFCONF method throughout.

Franks a lot,
David S. Miller
davem@redhat.com


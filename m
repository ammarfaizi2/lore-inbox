Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261367AbTCGG02>; Fri, 7 Mar 2003 01:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261376AbTCGG02>; Fri, 7 Mar 2003 01:26:28 -0500
Received: from pizda.ninka.net ([216.101.162.242]:38599 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261367AbTCGG01>;
	Fri, 7 Mar 2003 01:26:27 -0500
Date: Thu, 06 Mar 2003 22:18:42 -0800 (PST)
Message-Id: <20030306.221842.69294793.davem@redhat.com>
To: rusty@linux.co.intel.com
Cc: miyazawa@linux-ipv6.org, linux-kernel@vger.kernel.org
Subject: Re: Latest bk build error in xfrm.h
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1047000245.4169.45.camel@vmhack>
References: <1046986725.4169.40.camel@vmhack>
	<20030306.160300.126216253.davem@redhat.com>
	<1047000245.4169.45.camel@vmhack>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Lynch <rusty@linux.co.intel.com>
   Date: 06 Mar 2003 17:24:04 -0800

   There is still a build dependency between the INET_AH/INET_ESP and
   CRYPTO_HMAC that the Kconfig does not cover.  The following trivial
   patch fixes it:
   
Other way around, these selections are made before crypto's
Kconfig is run so you cannot check this dependency.

The default is properly handled in crypto/Kconfig when these
protocols are defined, you should have a look.

If a user intentionally enabled INET_AH/INET_ESP et al. then forcibly
disobeys the default setting for the necessary crypto options, that is
their problem :-)

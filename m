Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264547AbUAFRWh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 12:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264553AbUAFRWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 12:22:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:60562 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264547AbUAFRWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 12:22:36 -0500
Date: Tue, 6 Jan 2004 09:22:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: torvalds@osdl.org, James.Bottomley@SteelEye.com, johnstul@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix get_jiffies_64 to work on voyager
Message-Id: <20040106092237.4e617296.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.53.0401061807070.9108@gockel.physik3.uni-rostock.de>
References: <1073405053.2047.28.camel@mulgrave>
	<20040106081947.3d51a1d5.akpm@osdl.org>
	<Pine.LNX.4.58.0401060826570.2653@home.osdl.org>
	<Pine.LNX.4.53.0401061807070.9108@gockel.physik3.uni-rostock.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Schmielau <tim@physik3.uni-rostock.de> wrote:
>
>   #if (BITS_PER_LONG < 64)
>  @@ -21,7 +21,7 @@
>   #else
>   static inline u64 get_jiffies_64(void)
>   {
>  -	return (u64)jiffies;
>  +	return jiffies_64;
>   }
>   #endif

hm, why this change?  Are you sure that all 64-bit architectures alias
jiffies onto jiffies_64?  x86_64 seems not to.


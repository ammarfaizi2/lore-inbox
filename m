Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264589AbTLLNxq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 08:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264582AbTLLNxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 08:53:46 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:12810 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S264578AbTLLNxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 08:53:42 -0500
Date: Fri, 12 Dec 2003 22:46:49 +0900 (JST)
Message-Id: <20031212.224649.20046672.yoshfuji@linux-ipv6.org>
To: jmorris@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: sysctl vs /proc/sys
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <Xine.LNX.4.44.0312120815170.2611-100000@thoron.boston.redhat.com>
References: <20031212.215837.31545329.yoshfuji@linux-ipv6.org>
	<Xine.LNX.4.44.0312120815170.2611-100000@thoron.boston.redhat.com>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Xine.LNX.4.44.0312120815170.2611-100000@thoron.boston.redhat.com> (at Fri, 12 Dec 2003 08:20:41 -0500 (EST)), James Morris <jmorris@redhat.com> says:

> On Fri, 12 Dec 2003, YOSHIFUJI Hideaki / [iso-2022-jp] 吉藤英明 wrote:
> 
> > Or, I'd rather propose introducing sysctlbyname(2).
> 
> See the thread at 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=105788786819578&w=2

Thanks, James. I think I missed the thread.

Well, some applications which can run on *BSD* and Linux uses sysctl.
Because using procfs changes the semantics, I'd love to have sysctlbyname().

Can we get the exact previous value from /proc/sys atomicly?
If so, I'm ok not to have sysctlbyname(2) 
because we can have sysctlbyname(3).

If no, please let's have sysctlbyname(2); there ARE
something we cannot do only without sysctl variants.

Note: sysctlbyname(3) and sysctlnametomib(3) is in FreeBSD.

--yoshfuji



 

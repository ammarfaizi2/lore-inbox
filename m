Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbTLMAtH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 19:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbTLMAtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 19:49:07 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:23563 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S262598AbTLMAtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 19:49:05 -0500
Date: Sat, 13 Dec 2003 09:42:10 +0900 (JST)
Message-Id: <20031213.094210.107050343.yoshfuji@linux-ipv6.org>
To: mfedyk@matchmail.com
Cc: jmorris@redhat.com, linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: sysctl vs /proc/sys
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20031212181517.GM15401@matchmail.com>
References: <20031212.224649.20046672.yoshfuji@linux-ipv6.org>
	<Xine.LNX.4.44.0312120928120.2843-100000@thoron.boston.redhat.com>
	<20031212181517.GM15401@matchmail.com>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031212181517.GM15401@matchmail.com> (at Fri, 12 Dec 2003 10:15:17 -0800), Mike Fedyk <mfedyk@matchmail.com> says:

> On Fri, Dec 12, 2003 at 09:28:32AM -0500, James Morris wrote:
> > On Fri, 12 Dec 2003, YOSHIFUJI Hideaki / [iso-2022-jp] 吉藤英明 wrote:
> > 
> > > Can we get the exact previous value from /proc/sys atomicly?
> > 
> > I'm not sure what you mean by this.
> 
> Read value and modify in one op?

Yes, I meant to read old value and to set new one in one system call.
The sysctl system-call does lock_kernel, so sysctl(2) sytem-call 
are serialized.

How about procfs? Are there locks between multiple read-and-write?
Since It seems user-space cannot (or even should not) let kernel 
hold lock(s) during read-and-write operation, procfs cannot be 
the alternative.

Do I mis-understand something?

--yoshfuji

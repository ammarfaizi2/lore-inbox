Return-Path: <linux-kernel-owner+w=401wt.eu-S1755120AbWL3OTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755120AbWL3OTP (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 09:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755114AbWL3OTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 09:19:14 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:41384 "EHLO
	yue.st-paulia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754471AbWL3OTN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 09:19:13 -0500
Date: Sat, 30 Dec 2006 23:19:52 +0900 (JST)
Message-Id: <20061230.231952.16573563.yoshfuji@linux-ipv6.org>
To: komurojun-mbn@nifty.com
Cc: bunk@stusta.de, jgarzik@pobox.com, viro@ftp.linux.org.uk,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       davem@davemloft.net
Subject: Re: [BUG KERNEL 2.6.20-rc1] ftp: get or put stops during
 file-transfer
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20061230205931.9e430173.komurojun-mbn@nifty.com>
References: <20061230185043.d31d2104.komurojun-mbn@nifty.com>
	<20061230.102358.106876516.yoshfuji@linux-ipv6.org>
	<20061230205931.9e430173.komurojun-mbn@nifty.com>
Organization: USAGI/WIDE Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 3.3 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20061230205931.9e430173.komurojun-mbn@nifty.com> (at Sat, 30 Dec 2006 20:59:31 +0900), Komuro <komurojun-mbn@nifty.com> says:

> > Do you see similar issue with other simple application?
> 
> sorry, I don't reproduce this problem on other application.

Can you reproduce it with other ftp client and/or server?


Anyway...

Please provide the output of "netstat -na" command during the
transfer, and the output of "lsmod | grep conntrack" (just for
sure).


More questions:

What kind of mode do you use? e.g. PORT/EPRT/LPRT/PASV/EPSV/LPSV

When the transfer get stuck, are other communication still working?

Are there any workaround?
e.g. stop-start vsftpd cycle, ifdown-ifup cycle, rmmod/insmod cycle etc.


Regards,

--yoshfuji

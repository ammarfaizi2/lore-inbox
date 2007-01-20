Return-Path: <linux-kernel-owner+w=401wt.eu-S965360AbXATUQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965360AbXATUQY (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 15:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965368AbXATUQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 15:16:24 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:38243 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965360AbXATUQX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 15:16:23 -0500
From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Organization: TUBITAK/UEKAE
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: Abysmal disk performance, how to debug?
Date: Sat, 20 Jan 2007 22:16:15 +0200
User-Agent: KMail/1.9.5
Cc: Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
References: <200701201920.54620.ismail@pardus.org.tr> <200701201952.54714.ismail@pardus.org.tr> <Pine.LNX.4.63.0701202105210.23674@gockel.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.63.0701202105210.23674@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200701202216.16637.ismail@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

20 Oca 2007 Cts 22:10 tarihinde, Tim Schmielau şunları yazmıştı: 
[...]
>
> Note that these dd "benchmarks" are completely bogus, because the data=20
> doesn't actually get written to disk in that time. For some enlightening=20
> data, try
>
>   time dd if=3D/dev/zero of=3D/tmp/1GB bs=3D1M count=3D1024; time sync
>
> The dd returns as soon as all data could be buffered in RAM. Only sync=20
> will show how long it takes to actually write out the data to disk.
> also explains why you see better results is writeout starts earlier.

Still not that bad:

[~]> time dd if=/dev/zero of=/tmp/1GB bs=1M count=1024;sync
1024+0 records in
1024+0 records out
1073741824 bytes (1,1 GB) copied, 53,3194 s, 20,1 MB/s

real    0m53.517s
user    0m0.003s
sys     0m3.193s


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280620AbRLDRuQ>; Tue, 4 Dec 2001 12:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281566AbRLDRsY>; Tue, 4 Dec 2001 12:48:24 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:29090 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S282404AbRLDRru>;
	Tue, 4 Dec 2001 12:47:50 -0500
Message-ID: <3C0D0BFD.6080903@dplanet.ch>
Date: Tue, 04 Dec 2001 18:46:37 +0100
From: Giacomo Catenazzi <cate@dplanet.ch>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wayne.Brown@altec.com
CC: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
In-Reply-To: <86256B18.005EE7DC.00@smtpnotes.altec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Dec 2001 17:47:49.0079 (UTC) FILETIME=[C9F91E70:01C17CEB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wayne.Brown@altec.com wrote:

> 
> In fact, here's all I want to know about the whole CML2/kbuild 2.5 issue.  Right
> now I upgrade my kernel like this (simplified slightly):
> 
> <apply latest patches>
> mv .config ..
> make mrproper
> mv ../.config .
> make oldconfig
> make dep
> make bzlilo modules modules_install
> <reboot>
> 
> Will I still be able to do it this simply in 2.5.x?  (Assuming there's
> eventually a 2.5.x I can get to compile cleanly.  :-)
> 


Yes you can do.
hmm. only for the CML2 part. The new kbuild-2.5 (also the new Makefile)
will no more work with your command:
make dep: is no more needed
make bzlilo modules modules_install: it would be a simble
make install: (and you configure with CML1/CML2 what install
means).

	giacomo


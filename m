Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312317AbSCUAbG>; Wed, 20 Mar 2002 19:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312323AbSCUAas>; Wed, 20 Mar 2002 19:30:48 -0500
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:59877 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S312321AbSCUAam>; Wed, 20 Mar 2002 19:30:42 -0500
Message-ID: <3C9929B6.2040203@drugphish.ch>
Date: Thu, 21 Mar 2002 01:30:46 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020306
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hugang <gang_hu@soul.com.cn>
Cc: adasi@kernel.pl, linux-kernel@vger.kernel.org
Subject: Re: [2.5.7] compilation problem
In-Reply-To: <006301c1ceca$87937c70$0201a8c0@WITEK>	<3C967FB2.1080706@drugphish.ch> <20020319154853.43fbe03b.gang_hu@soul.com.cn>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Today I download the latest patch, And I patch it into 
 > the 2.5.6 tree, But it do't have that problem.?
 > I chech dev.c , that is right.

Funny, the patches (from 2.5.6 to 2.5.7 and from 2.5.7-pre2 to 2.5.7) I 
downloaded from ftp.kernel.org do contain following patch:

laphish:/usr/src/patches # grep handle_diverter *
patch-2.5.7:- 
			handle_diverter(skb);
patch-2.5.7:+ 
	ret = handle_diverter(skb);
patch-2.5.7-pre2:- 
			handle_diverter(skb);
patch-2.5.7-pre2:+ 
	ret = handle_diverter(skb);
laphish:/usr/src/patches #

My patch reverts this but since you mention that for you it was correct 
I wonder if we're really talking about the same patch so I just 
downloaded them again and I can verify that the problem is really present:

ratz@laphish:~ > md5sum patch-2.5.7.*
f89d55b1e94fbd974d8b3f4625a86a2a  patch-2.5.7.bz2
0f5dec319d693dfe6c528a76e10cd1d1  patch-2.5.7.gz
ratz@laphish:~ > bunzip2 patch-2.5.7.bz2
ratz@laphish:~ > grep handle_diverter patch-2.5.7
- 
			handle_diverter(skb);
+ 
	ret = handle_diverter(skb);
ratz@laphish:~ > rm patch-2.5.7
ratz@laphish:~ > gunzip patch-2.5.7.gz
ratz@laphish:~ > grep handle_diverter patch-2.5.7
- 
			handle_diverter(skb);
+ 
	ret = handle_diverter(skb);
ratz@laphish:~ > rm patch-2.5.7
ratz@laphish:~ >

Cheers,
Roberto Nibali, ratz


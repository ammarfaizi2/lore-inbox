Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263128AbTEMCNx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 22:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263130AbTEMCNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 22:13:53 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:22277 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S263128AbTEMCNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 22:13:51 -0400
Date: Tue, 13 May 2003 11:26:56 +0900 (JST)
Message-Id: <20030513.112656.112825273.yoshfuji@linux-ipv6.org>
To: chris@wirex.com, davem@redhat.com
Cc: torvalds@transmeta.com, dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix net/rxrpc/proc.c
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20030512190036.B20068@figure1.int.wirex.com>
References: <20030512173801.A20068@figure1.int.wirex.com>
	<1052790558.9169.2.camel@rth.ninka.net>
	<20030512190036.B20068@figure1.int.wirex.com>
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

In article <20030512190036.B20068@figure1.int.wirex.com> (at Mon, 12 May 2003 19:00:36 -0700), Chris Wright <chris@wirex.com> says:

> * David S. Miller (davem@redhat.com) wrote:
> > On Mon, 2003-05-12 at 17:38, Chris Wright wrote:
> > > A recent change in 2.5.69-bk from Yoshfuji broke compilation of rxrpc
> > > code.  It erroneously adds an owner field to the rxrpc_proc_peers_ops
> > > seq_operations.  Fix below.
> > 
> > Why is it "erroneous"?  Just add the proper linux/module.h include
> > to net/rxrpc/proc.c instead of spewing baseless claims.
> 
> Sorry, if I'm missing the obvious, but looking at my current bk tree I
> see this:
> 
> include/linux/seq_file.h
> 
> struct seq_operations {
> 	void * (*start) (struct seq_file *m, loff_t *pos);
> 	void (*stop) (struct seq_file *m, void *v);
> 	void * (*next) (struct seq_file *m, void *v, loff_t *pos);
> 	int (*show) (struct seq_file *m, void *v);
> };
> 
> It looks to me like there is a simple mistake of seq_operations !=
> file_operations when adding .owner = THIS_MODULE to the file_operations.

Sorry, it's my mistake.   David, please apply his patch.

--yoshfuji

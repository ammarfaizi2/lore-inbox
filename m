Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263150AbTEMCxj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 22:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTEMCxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 22:53:39 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:47344 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S263150AbTEMCxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 22:53:38 -0400
Date: Mon, 12 May 2003 20:05:30 -0700
From: Chris Wright <chris@wirex.com>
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B" <yoshfuji@linux-ipv6.org>
Cc: chris@wirex.com, davem@redhat.com, torvalds@transmeta.com,
       dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix net/rxrpc/proc.c
Message-ID: <20030512200530.I19432@figure1.int.wirex.com>
Mail-Followup-To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B" <yoshfuji@linux-ipv6.org>,
	chris@wirex.com, davem@redhat.com, torvalds@transmeta.com,
	dhowells@redhat.com, linux-kernel@vger.kernel.org
References: <20030512173801.A20068@figure1.int.wirex.com> <1052790558.9169.2.camel@rth.ninka.net> <20030512190036.B20068@figure1.int.wirex.com> <20030513.112656.112825273.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030513.112656.112825273.yoshfuji@linux-ipv6.org>; from yoshfuji@linux-ipv6.org on Tue, May 13, 2003 at 11:26:56AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B (yoshfuji@linux-ipv6.org) wrote:
> 
> Sorry, it's my mistake.   David, please apply his patch.

Thanks, sorry, I should have Cc:'d you in the first place, my apology.
Seems like the rxrpc_proc_calls_fops should get an owner as well?  (relative
to the last patch)

thanks,
-chris

===== net/rxrpc/proc.c 1.3 vs edited =====
--- 1.3/net/rxrpc/proc.c	Sat May 10 11:46:35 2003
+++ edited/net/rxrpc/proc.c	Mon May 12 19:56:20 2003
@@ -102,6 +101,7 @@
 };
 
 static struct file_operations rxrpc_proc_calls_fops = {
+	.owner		= THIS_MODULE,
 	.open		= rxrpc_proc_calls_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,

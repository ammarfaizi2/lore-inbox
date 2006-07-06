Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030335AbWGFP2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030335AbWGFP2I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 11:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbWGFP2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 11:28:07 -0400
Received: from pat.uio.no ([129.240.10.4]:25260 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030335AbWGFP2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 11:28:06 -0400
Subject: Re: [BUG] NFS with multiple clients connected
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Razvan Gavril <razvan.g@plutohome.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44AD292E.6040100@plutohome.com>
References: <44AD292E.6040100@plutohome.com>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 11:27:52 -0400
Message-Id: <1152199672.19924.1.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.255, required 12,
	autolearn=disabled, AWL 1.56, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-06 at 18:15 +0300, Razvan Gavril wrote:
> I have a nfs server(kernel-server) which i use as a boot server for 
> several other machines on the network. Starting with 2.6.16 i started 
> noticing that when having more than one of the clients doing a lot of 
> in/out on their mounted nfs shares at list one of then starts to to have 
> problems when writing (don't know about reading) files. For example dpkg 
> writes strange things it the /var/lib/dpkg/status file even if it worked 
> perfectly before the kernel upgrade.
> 
> Every time an diskless computer fails to write corectly to the nfs 
> filesystem i got this messages on the nfs server (dmesg):
> 
> RPC: bad TCP reclen 0x3c390000 (large)
> RPC: bad TCP reclen 0x31006261 (non-terminal)
> RPC: bad TCP reclen 0x73752070 (non-terminal)
> RPC: bad TCP reclen 0x52610100 (non-terminal)
> 
> Is very simple to spot this behaver (1 write-error for client / 1 rpc 
> message in server's dmesg) because apt-get is always giving an error 
> message when the /var/lib/dpkg/status file contains something that it 
> shouldn't. An it also can be very ease to reproduce.
> 
> I tested with 2.6.17 and got the same error, although when using 2.6.15 
> didn't got any errors and the clients worked perfect. Since i'm kind of 
> forced to use a kernel version > 2.6.15 i really, really need to solve 
> this bug. I would be glad to do it myself but i don't have the knowledge 
> to do it so if is anybody that can help i can offer all the information 
> that i could and also access to a system so he can track the problem.
> 
> 
> --
> Razvan Gavril

Did the problem start when you upgraded the clients or the server?

Cheers,
  Trond



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbVCFFsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVCFFsk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 00:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVCFFsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 00:48:40 -0500
Received: from pat2.uio.no ([129.240.130.19]:55433 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261321AbVCFFsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 00:48:36 -0500
Subject: Re: Linux 2.6.11
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1110068394l.11446l.1l@werewolf.able.es>
References: <Pine.LNX.4.58.0503012356480.25732@ppc970.osdl.org>
	 <1110068394l.11446l.1l@werewolf.able.es>
Content-Type: text/plain
Date: Sun, 06 Mar 2005 00:48:16 -0500
Message-Id: <1110088096.16110.3.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.412, required 12,
	autolearn=disabled, AWL 1.54, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

su den 06.03.2005 Klokka 00:19 (+0000) skreiv J.A. Magallon:

> static int __init init_nfsd(void)
> {
> ...
>     if (proc_mkdir("fs/nfs", NULL)) {
>         struct proc_dir_entry *entry;
>         entry = create_proc_entry("fs/nfs/exports", 0, NULL);
>         if (entry)
>             entry->proc_fops =  &exports_operations;
>     }
> ...
> 
> But nfs-utils 1.0.7 say that you can mount nfsd at /proc/fs/nfsd.
> What 'exports' would kernel use ? Just duplicate info or a bug ?

Not sure why /proc/fs/nfs was originally chosen (perhaps Neil knows?),
but the above code has nothing to do with where you mount the "nfsd"
filesystem. It is rather part of the legacy support for older versions
of nfs-utils.

We should aim to deprecate it at some point soon.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>


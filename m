Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261807AbSJQWG3>; Thu, 17 Oct 2002 18:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262194AbSJQWG3>; Thu, 17 Oct 2002 18:06:29 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:14608 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP
	id <S261807AbSJQWG1>; Thu, 17 Oct 2002 18:06:27 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] remove sys_security
Date: 17 Oct 2002 21:54:49 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <aonbj9$pun$1@abraham.cs.berkeley.edu>
References: <20021017195015.A4747@infradead.org> <20021017185352.GA32537@kroah.com> <20021017.131830.27803403.davem@redhat.com>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1034891689 26583 128.32.153.211 (17 Oct 2002 21:54:49 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 17 Oct 2002 21:54:49 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>Who is going to use this stuff?  %99.999 of users
>will never load a security module, and the distribution makers are
>going to enable this NOP overhead for _everyone_ just so a few telcos
>or government installations can get their LSM bits?

I don't understand how anyone can possibly know that.
It's true that today very few users use security modules,
but the Linux kernel doesn't support loadable security modules
today, so it would be unreasonable to use today's figures to
estimate likely future usage.

>This doesn't make any sense to me, including LSM appears to be quite
>against one of the basic maxims of Linux kernel ideology if you ask me
>:-)  (said maxim is: If %99 of users won't use it, they better not
>even notice it is there or be affected by it in any way)

Ahh, good.  Then you should be pretty happy with the current LSM
framework.  I believe that users who don't load a LSM module won't
notice anything.  For example, the LSM folks have several performance
measurements that show that the performance overhead of LSM is basically
negligible, so that's one way that users won't notice it is there.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbVC0OAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVC0OAE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 09:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbVC0OAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 09:00:04 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:48567 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261657AbVC0OAB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 09:00:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Z/FHdZXOKE3yRoTCJuoacrr+1rlm3R9+GDXHfVBrPyRnq0nG1XNRz7eh5fAbCBAEvKIYFnbdyNk9oPtfkbfWzU1G9SAK+QaLlwb3osIGGkc/uEkp07izbj6a31WWVMuZMOPxRygJp1hXblXVEW9XOtEADapq4mS86ZD5cAtDvbc=
Message-ID: <84144f02050327060051b61e54@mail.gmail.com>
Date: Sun, 27 Mar 2005 17:00:01 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: linux-os@analogic.com
Subject: Re: [PATCH] remove redundant NULL pointer checks prior to calling kfree() in fs/nfsd/
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Neil Brown <neilb@cse.unsw.edu.au>,
       nfs@lists.sourceforge.net, Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, penberg@cs.helsinki.fi
In-Reply-To: <Pine.LNX.4.61.0503251731240.6372@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.62.0503252319220.2498@dragon.hyggekrogen.localhost>
	 <Pine.LNX.4.61.0503251731240.6372@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Mar 2005 17:34:29 -0500 (EST), linux-os
<linux-os@analogic.com> wrote:
> You really should reconsider this activity. It is quite counter-productive.

No it's not. NULL is checked twice without Jesper's cleanups. If
kfree() calls are really that performance sensitive, just make it
inline and GCC will take care of it.

                                        Pekka

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269678AbSIRXtS>; Wed, 18 Sep 2002 19:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269677AbSIRXtS>; Wed, 18 Sep 2002 19:49:18 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:60656
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S269678AbSIRXtR>; Wed, 18 Sep 2002 19:49:17 -0400
Subject: Re: [PATCH] zerocopy NFS for 2.5.36
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: taka@valinux.co.jp, neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
In-Reply-To: <20020918.160057.17194839.davem@redhat.com>
References: <20020918.171431.24608688.taka@valinux.co.jp> 
	<20020918.160057.17194839.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Sep 2002 00:54:37 +0100
Message-Id: <1032393277.24895.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-19 at 00:00, David S. Miller wrote:
> It was discussed long ago that csum_and_copy_from_user() performs
> better than plain copy_from_user() on x86.  I do not remember all

The better was a freak of PPro/PII scheduling I think

> details, but I do know that using copy_from_user() is not a real
> improvement at least on x86 architecture.

The same as bit is easy to explain. Its totally memory bandwidth limited
on current x86-32 processors. (Although I'd welcome demonstrations to
the contrary on newer toys)


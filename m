Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319352AbSIKVj0>; Wed, 11 Sep 2002 17:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319359AbSIKVj0>; Wed, 11 Sep 2002 17:39:26 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:18173
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319352AbSIKVjZ>; Wed, 11 Sep 2002 17:39:25 -0400
Subject: Re: Killing/balancing processes when overcommited
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jim Sibley <jlsibley@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, riel@conectiva.com.br, ltc@linux.ibm.com,
       Troy Reed <tdreed@us.ibm.com>
In-Reply-To: <OFA28F240F.93209971-ON88256C31.005E5F03@boulder.ibm.com>
References: <OFA28F240F.93209971-ON88256C31.005E5F03@boulder.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 11 Sep 2002 22:44:24 +0100
Message-Id: <1031780664.2994.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-11 at 19:08, Jim Sibley wrote:
> I have run into a situation in a multi-user Linux environment that when
> memory is exhausted, random things happen. The best case is that the
> "offending" user's task is killed. Just as likely, another user's task is

The best case is that you don't allow overcommit. 2.4 supports that in
the Red Hat and -ac trees. Robert Love forward ported the changes to
2.5.x. There is an outstanding need to add an additional "root factor"
so root can get some memory other people cannot, but otherwise it seems
to work well


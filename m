Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261642AbVDEISl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbVDEISl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 04:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVDEIOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 04:14:30 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:41145 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261650AbVDEILf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 04:11:35 -0400
Subject: Re: Netlink Connector / CBUS
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: lkml <linux-kernel@vger.kernel.org>, Netlink List <netdev@oss.sgi.com>,
       "David S. Miller" <davem@davemloft.net>,
       James Morris <jmorris@redhat.com>, rml@novell.com,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>
In-Reply-To: <1112686480.28858.17.camel@uganda>
References: <Xine.LNX.4.44.0504050108260.9383-100000@thoron.boston.redhat.com>
	 <1112686480.28858.17.camel@uganda>
Date: Tue, 05 Apr 2005 10:11:23 +0200
Message-Id: <1112688683.8456.10.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 05/04/2005 10:21:14,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 05/04/2005 10:21:15,
	Serialize complete at 05/04/2005 10:21:15
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-05 at 11:34 +0400, Evgeniy Polyakov wrote:
> On Tue, 2005-04-05 at 01:10 -0400, Herbert Xu wrote:
>
> >In fact to this day I still don't understand what problems this thing is
> >meant to solve.
> 
> Hmm, what else can I add to my words?
> May be checking the size of the code needed to broadcast kobject changes
> in kobject_uevent.c for example...
> Netlink socket allocation + skb handling against call to cn_netlink_send().

And It's the same for the fork connector. It allows to send a message to
a user space application when a fork occurs by adding only one line (two
with the #include) in the kernel/fork.c file. Thus, the netlink
connector is a very simple and fast mechanism when you need to send a
small amount of information from kernel space to user space.

Regards,
Guillaume


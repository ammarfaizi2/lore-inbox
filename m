Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbUGaUkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUGaUkY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 16:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUGaUkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 16:40:24 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:13237 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262138AbUGaUkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 16:40:16 -0400
Subject: Re: PATCH: VLAN support for 3c59x/3c90x
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Cox <alan@redhat.com>
Cc: Ben Greear <greearb@candelatech.com>, Willy Tarreau <willy@w.ods.org>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Herbert Xu <herbert@gondor.apana.org.au>, Andrew Morton <akpm@osdl.org>,
       jgarzik@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040731202557.GA20472@devserv.devel.redhat.com>
References: <20040730121004.GA21305@alpha.home.local>
	 <E1BqkzY-0003mK-00@gondolin.me.apana.org.au>
	 <20040731083308.GA24496@alpha.home.local> <410B67B1.4080906@pobox.com>
	 <20040731101152.GG1545@alpha.home.local>
	 <20040731141222.GJ2429@mea-ext.zmailer.org>
	 <410BD0E3.2090302@candelatech.com>
	 <20040731170551.GA27559@alpha.home.local>
	 <410BD525.3010102@candelatech.com> <1091304989.1677.329.camel@mindpipe>
	 <20040731202557.GA20472@devserv.devel.redhat.com>
Content-Type: text/plain
Message-Id: <1091306443.1677.351.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 31 Jul 2004 16:40:43 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-31 at 16:25, Alan Cox wrote:
> On Sat, Jul 31, 2004 at 04:16:29PM -0400, Lee Revell wrote:
> > UDP is prone to *much* weirded behavior than TCP in the face of things
> > like this.  I once had an NFS server and client using UDP.  A had its
> > block size set to 8K, B to 32K.  For some reason the mount succeeded
> 
> Thats NFS weirdness. NFS (especially older Linux NFS) is the problem not
> the UDP layer. UDP is wonderfully bug free in most situations because
> its so simple it forces the bugs up a protocol layer
> 

Yes, it seems like there are two choices at that point - bail, or take a
wild guess as to what you're supposed to do.  I think the mount
succeeded because no one was required to send more than 8K at once. 
IIRC A was BSD/OS 4.x, B was Linux 2.4.x.

Man, that was a weird bug.  Took me *days* to pin down, because it would
mysteriously disappear as long as you only dealt with files < 8K.  Which
as it turns out is almost all of them except the password file.

Lee


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264324AbTLKCji (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 21:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264331AbTLKCji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 21:39:38 -0500
Received: from dh197.citi.umich.edu ([141.211.133.197]:26508 "EHLO
	nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S264324AbTLKCjg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 21:39:36 -0500
Subject: Re: NFS errors in 2.6
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Miles Bader <miles@gnu.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
In-Reply-To: <buooeugccz8.fsf@mcspd15.ucom.lsi.nec.co.jp>
References: <buobrqhun6r.fsf@mcspd15.ucom.lsi.nec.co.jp>
	 <shsu148ajbv.fsf@guts.uio.no>  <buooeugccz8.fsf@mcspd15.ucom.lsi.nec.co.jp>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1071110374.28948.12.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 10 Dec 2003 21:39:34 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På on , 10/12/2003 klokka 21:19, skreiv Miles Bader:

> Hmmm; I did a packet-trace on the 2.4.23 traffic for the same user
> command, and it doesn't use READDIRPLUS at all (does 2.4.23 not support
> NFS V3, or does it just use a different algorithm for reading
> directories?), so maybe the server's just broken.  Gah...
> 

The 2.4.23 NFSv3 client does not support READDIRPLUS without extra
patches, so that would explain why you haven't seen the problem before.

Note, though, that those patches have been around for almost 3 years,
and have been tested pretty extensively against Solaris servers. I've
never seen any reports of this particular problem before.

If you'd like to try the 2.4.23 readdirplus patches, then you can find
them as part of

http://www.fys.uio.no/~trondmy/src/Linux-2.4.x/2.4.23-rc1/linux-2.4.23-NFS_ALL.dif

however as I said; given your ethereal dump, I suspect something is
screwed on the server itself...

Cheers,
  Trond

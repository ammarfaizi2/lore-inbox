Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264500AbUFJC7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbUFJC7K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 22:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266108AbUFJC7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 22:59:10 -0400
Received: from mail.autoweb.net ([198.172.237.26]:42256 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S264500AbUFJC7G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 22:59:06 -0400
Date: Wed, 9 Jun 2004 22:58:50 -0400
From: Ryan Anderson <ryan@michonline.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.X File locking on NFS stil broken
Message-ID: <20040610025849.GA20151@michonline.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040609191758.GA29969@puettmann.net> <1086813672.4078.24.camel@lade.trondhjem.org> <20040609204235.GC29969@puettmann.net> <1086814428.4078.35.camel@lade.trondhjem.org> <20040609210313.GE29969@puettmann.net> <1086815623.4078.43.camel@lade.trondhjem.org> <20040609212430.GG29969@puettmann.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040609212430.GG29969@puettmann.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 11:24:30PM +0200, Ruben Puettmann wrote:
> On Wed, Jun 09, 2004 at 05:13:43PM -0400, Trond Myklebust wrote:
> > P? on , 09/06/2004 klokka 17:03, skreiv Ruben Puettmann:
> > 
> > > attached the strace and one tcpdump from the testprogramm.
> > 
> > According to that tcpdump, the server is denying you the lock because it
> > is still in its grace period. 
> > 
> > During that period only clients that held locks before the server
> > rebooted are allowed to reclaim those locks. Your client will need to
> > wait until that grace period is over (usually ~ 1 minute or so).
> 
> I have done a reboot on teh server ( It was up for over 315 day's ;-( )
> now all runs fine seems to be an race condition. I will take a look on
> it if this happend again. 

Did you change libc and/or your DNS configuration without restarting
nfs-common? (statd/lockd)

-- 

Ryan Anderson

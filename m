Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266553AbUGKK2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266553AbUGKK2V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 06:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266555AbUGKK2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 06:28:21 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:15119 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S266553AbUGKK2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 06:28:02 -0400
Date: Sun, 11 Jul 2004 18:16:05 +0800 (WST)
From: raven@themaw.net
To: Thomas Moestl <moestl@ibr.cs.tu-bs.de>
cc: autofs mailing list <autofs@linux.kernel.org>, nfs@lists.sourceforge.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: umount() and NFS races in 2.4.26
In-Reply-To: <20040710181912.GA800@timesink.dyndns.org>
Message-ID: <Pine.LNX.4.58.0407111812460.1900@donald.themaw.net>
References: <20040708180709.GA7704@timesink.dyndns.org>
 <Pine.LNX.4.58.0407101419210.1378@donald.themaw.net> <20040710181912.GA800@timesink.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-1.2, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, NO_REAL_NAME, QUOTED_EMAIL_TEXT,
	RCVD_IN_ORBS, REFERENCES, REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jul 2004, Thomas Moestl wrote:

> > Never the less I'm sure there is a race in waitq.c of autofs4 in 
> > 2.4 that seems to cause this problem. This is one of the things 
> > addressed by my patch.
> 
> The system in question still uses autofs3. While I believe that the
> waitq race is also present there (it could probably cause directory
> lookups to hang, if I understand it correctly), I do not think that
> any autofs3 code could cause exactly those symptoms that I have
> observed. For that, it would have to obtain dentries of the file
> systems that it has mounted, but the old code never does that.

I don't think autofs v3 has this race. It uses the BKL everywhere to 
serialise execution. Never the less people seem to see the "busy inode" 
messages sometimes.

Ian


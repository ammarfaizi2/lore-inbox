Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266365AbUGJTti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266365AbUGJTti (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 15:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266370AbUGJTti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 15:49:38 -0400
Received: from mail.gmx.de ([213.165.64.20]:21193 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266365AbUGJTtd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 15:49:33 -0400
X-Authenticated: #5374206
Date: Sat, 10 Jul 2004 21:50:01 +0200
From: Thomas Moestl <moestl@ibr.cs.tu-bs.de>
To: raven@themaw.net
Cc: autofs mailing list <autofs@linux.kernel.org>, nfs@lists.sourceforge.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: umount() and NFS races in 2.4.26
Message-ID: <20040710195001.GC800@timesink.dyndns.org>
References: <20040708180709.GA7704@timesink.dyndns.org> <Pine.LNX.4.58.0407101419210.1378@donald.themaw.net> <20040710181912.GA800@timesink.dyndns.org> <Pine.LNX.4.58.0407110323480.20439@donald.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0407110323480.20439@donald.themaw.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004/07/11 at 03:25:34 +0800, raven@themaw.net wrote:
> On Sat, 10 Jul 2004, Thomas Moestl wrote:
> > The system in question still uses autofs3. While I believe that the
> > waitq race is also present there (it could probably cause directory
> > lookups to hang, if I understand it correctly), I do not think that
> > any autofs3 code could cause exactly those symptoms that I have
> > observed. For that, it would have to obtain dentries of the file
> > systems that it has mounted, but the old code never does that.
> 
> All autofs has to do is not delete a directory before exiting for this 
> error to occur.

But in that case, the left-over dentry would be an autofs one, would
it not? In our case, the dentries were verified to belong to a NFS
mount that was unmounted by the automounter (that was one of the
symptoms I was referring to). The automounter itself was still
running, and the autofs still mounted.

	- Thomas

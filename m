Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262095AbVCHTU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbVCHTU2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 14:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbVCHTTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 14:19:32 -0500
Received: from moutng.kundenserver.de ([212.227.126.191]:3311 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262085AbVCHTSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 14:18:17 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: utz lehmann <lkml@s2y4n2c.de>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, Paul Davis <paul@linuxaudiosystems.com>,
       joq@io.com, cfriesen@nortelnetworks.com, chrisw@osdl.org,
       hch@infradead.org, rlrevell@joe-job.com, arjanv@redhat.com,
       mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050308043349.GG3120@waste.org>
References: <20050112185258.GG2940@waste.org>
	 <200501122116.j0CLGK3K022477@localhost.localdomain>
	 <20050307195020.510a1ceb.akpm@osdl.org>  <20050308043349.GG3120@waste.org>
Content-Type: text/plain
Date: Tue, 08 Mar 2005 20:17:42 +0100
Message-Id: <1110309462.5834.4.camel@segv.aura.of.mankind>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a3828f1c4d839cf12e8a3b808f7ed34
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-07 at 20:33 -0800, Matt Mackall wrote:
> On Mon, Mar 07, 2005 at 07:50:20PM -0800, Andrew Morton wrote:
> > 
> > So I still have the rt-lsm patch floating about, saying "merge me, merge
> > me!".  I'm not sure that the world would end were I to do so.
> > 
> > Consider this a prod in the direction of those who were pushing
> > alternatives ;)
> 
> I think Chris Wright's last rlimit patch is more sensible and ready to
> go. And I think I may have even convinced Ingo on this point before
> the conversation died last time around. So here's that patch again,
> updated to 2.6.11. Compiles cleanly. Chris, please add a signed-off-by.
> 
> <snip>
> 
> Add a pair of rlimits for allowing non-root tasks to raise nice and rt
> priorities. Defaults to traditional behavior. Originally written by
> Chris Wright.

The nice part is really useful for me. With it i can allow users to
renice their previously niced jobs (eg. from 19 to 0). At the moment
they need to call me and i do this as root.

If this rlimit approach is not the solution for the audio RT stuff, can
the nice part merged anyway?

utz



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266147AbTGMBK4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 21:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270053AbTGMBK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 21:10:56 -0400
Received: from mail3.panix.com ([166.84.1.74]:20194 "EHLO mail3.panix.com")
	by vger.kernel.org with ESMTP id S266147AbTGMBKz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 21:10:55 -0400
Date: Sat, 12 Jul 2003 18:25:43 -0700
From: Jeff Lightfoot <jeffml@pobox.com>
To: j.dittmer@portrix.net (Jan Dittmer)
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: 'NFS stale file handle' with 2.5
Message-Id: <20030712182543.2be6c988.jeffml@pobox.com>
In-Reply-To: <3F1068C9.1070900@portrix.net>
References: <3F1068C9.1070900@portrix.net>
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i386-pc-linux-gnu)
X-Face: $n=Rh`fC)-'~T?N4{k<m#PDTgj\,OYTK+D(!TTIdBm&(^y:ydlx9:~xe.1@_]/h!~a]D.Ja
 T)qLF2A(b!G{>=V~zorpO2&"J`qbq{|eiZ&k.#tAz{{7.3M_}Y?qY1sB}1,-F
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jul 2003 13:05:13 -0700
j.dittmer@portrix.net (Jan Dittmer) wrote:

> I'm experiencing really big problems with nfs on 2.5 - and I'm a bit
> stuck debugging.

I'm going to throw in a 'me too' on this one also.  I haven't done
much to narrow it down because at first I thought I fixed it by using
the same kernel version on both client and server.  Once the stale
file handle errors started showing up again I noticed that Trond
mentioned on LK the problem with soft versus hard.  So I figured some
changes in the NFS code finally caused soft mounts to not work so
well.

I changed over to hard,intr but the stale file handles have shown up
again.  It looks like it might be something that shows up over time
because it works fine for awhile after reboots but eventually
starts giving errors.

UP for both, 2.5.75-mm1

I'm willing to help debug also.

> # grep NFS .config
> CONFIG_NFS_FS=m
> CONFIG_NFS_V3=y
> CONFIG_NFS_V4=y
> CONFIG_NFS_DIRECTIO=y
> CONFIG_NFSD=m
> CONFIG_NFSD_V3=y
> CONFIG_NFSD_V4=y
> CONFIG_NFSD_TCP=y

Just in case this will help: (server and client)

CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
# CONFIG_NFSD_TCP is not set

-- 
Jeff Lightfoot    --    jeffml@pobox.com    --    http://thefoots.com/
    "I see the light at the end of the tunnel now ... someone please
    tell me it's not a train" -- Cracker

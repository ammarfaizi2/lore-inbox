Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQKICQj>; Wed, 8 Nov 2000 21:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129044AbQKICQT>; Wed, 8 Nov 2000 21:16:19 -0500
Received: from smtp08.phx.gblx.net ([206.165.6.138]:33507 "EHLO
	smtp08.phx.gblx.net") by vger.kernel.org with ESMTP
	id <S129033AbQKICQI>; Wed, 8 Nov 2000 21:16:08 -0500
Date: Wed, 8 Nov 2000 21:15:38 -0500
From: Scott McDermott <vaxerdec@frontiernet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Stange NFS messages - 2.2.18pre19
Message-ID: <20001108211538.C14262@vaxerdec>
Mail-Followup-To: Scott McDermott <vaxerdec>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10011072326340.21756-100000@iq.rulez.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10011072326340.21756-100000@iq.rulez.org>; from sape@iq.rulez.org on Tue, Nov 07, 2000 at 11:28:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sasi Peter on Tue  7/11 23:28 +0100:
> I'm getting this under moderate NFS load:
> Nov  6 17:39:56 iq kernel: svc: server socket destroy delayed (sk_inuse: 1)
> Nov  6 17:40:08 iq kernel: svc: unknown program 100227 (me 100003)
> Nov  6 19:06:11 iq kernel: svc: server socket destroy delayed (sk_inuse: 1)
> Nov  6 19:38:48 iq kernel: svc: server socket destroy delayed (sk_inuse: 1)
> 
> What do these means? Is this a kernel bug?

Your Suns are using TCP mounts, this got introduced into 2.2.18
somewhere and is a bit broken, do a patch -R with
ftp://oss.sgi.com/www.projects/nfs3/download/nfs_tcp-2.2.17.dif and
these go away.  Suns try TCP mounts first.  Be careful to unmount them
first or they will hang waiting for the TCP server to come back up.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

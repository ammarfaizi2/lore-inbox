Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268054AbUIBJpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268054AbUIBJpf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 05:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268056AbUIBJpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 05:45:35 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:38642 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S268054AbUIBJpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 05:45:33 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Thu, 02 Sep 2004 11:44:21 +0200
To: electronerd@monolith3d.com, christer@weinigel.se
Cc: schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org,
       der.eremit@email.de, axboe@suse.de
Subject: Re: (was: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices)
Message-ID: <4136EB75.nailB22112H09@burner>
References: <2ptdY-42Y-55@gated-at.bofh.it>
 <2uPdM-380-11@gated-at.bofh.it> <2uUwL-6VP-11@gated-at.bofh.it>
 <2uWfh-8jo-29@gated-at.bofh.it> <2uXl0-Gt-27@gated-at.bofh.it>
 <2vge2-63k-15@gated-at.bofh.it> <2vgQF-6Ai-39@gated-at.bofh.it>
 <2vipq-7O8-15@gated-at.bofh.it> <2vj2b-8md-9@gated-at.bofh.it>
 <2vDtS-bq-19@gated-at.bofh.it> <E1ByXMd-00007M-4A@localhost>
 <412770EA.nail9DO11D18Y@burner> <412889FC.nail9MX1X3XW5@burner>
 <Pine.LNX.4.58.0408221450540.297@neptune.local>
 <m37jrr40zi.fsf@zoo.weinigel.se> <4134FA0B.6030404@monolith3d.com>
In-Reply-To: <4134FA0B.6030404@monolith3d.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Myers <electronerd@monolith3d.com> wrote:

> I hope this is not a stupid idea:
>
> I propose a finer-grained approach to suid-root binaries. Perhaps, 
> instead of having a single flag giving the binary all the rights and 
> responsibilities of its owner, there could be a table/list/something of 
> capabilities which we want to grant to the binary. This, of course, 
> would be a privileged operation (perhaps a new capability?).
>
> For example, we might want to grant cdrecord CAP_SYS_RAWIO. This way, we 
> don't have to worry about cdrecord running as root and not dropping all 
> the capabilities it doesn't need, by accident or by malice.

cdrecord neither does drop the privileges by accident nor by malice.
What I however see is that a completely unneeded incompatible interface change 
has been applied to a _stable_ Kernel.

On a cleanly designed OS with fine grained permissions, a program like cdrecord
does not need to worry about the permissions as it gets exactly the needed 
permissions granted by the execution environment.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily

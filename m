Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264658AbUGHNXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264658AbUGHNXv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 09:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbUGHNXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 09:23:51 -0400
Received: from 8.75.30.213.rev.vodafone.pt ([213.30.75.8]:781 "EHLO
	odie.graycell.biz") by vger.kernel.org with ESMTP id S264658AbUGHNXp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 09:23:45 -0400
Subject: Re: soft deadlock in blk_congestion_wait (2.6.7)
From: Nuno Ferreira <nuno.ferreira@graycell.biz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E1BiVFa-0003uQ-00@dorka.pomaz.szeredi.hu>
References: <E1BiVFa-0003uQ-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Organization: Graycell
Date: Thu, 08 Jul 2004 14:23:42 +0100
Message-Id: <1089293022.2336.20.camel@taz.graycell.biz>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.2 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Jul 2004 13:23:42.0900 (UTC) FILETIME=[CA1B5740:01C464EE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Qui, 2004-07-08 at 11:31 +0200, Miklos Szeredi wrote:
> While running LTP tests (more specifically the ftest* testcases) on
> FUSE (http://sourceforge.net/projects/avf), I run into the following
> problem: the process serving the FUSE filesystem requests does some
> debugging write to an ext3 filesystem, and deadlocks in
> blk_congestion_wait:

 [...]

> I've seen a very similar report for CIFS here:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=108807439504273&w=2
> 

I reported that bug, and at least for CIFS it was fixed using the patch
mentioned a few mails later on that thread, see
http://marc.theaimsgroup.com/?l=linux-kernel&m=108846032716689&w=2

I can no longer reproduce the problem, but it may be that the patch only
made it harder to trigger.

-- 
Nuno Ferreira


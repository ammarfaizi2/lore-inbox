Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318177AbSGWRGW>; Tue, 23 Jul 2002 13:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318189AbSGWRFx>; Tue, 23 Jul 2002 13:05:53 -0400
Received: from ns.suse.de ([213.95.15.193]:56846 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318176AbSGWREr>;
	Tue, 23 Jul 2002 13:04:47 -0400
To: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with msync system call
References: <EE83E551E08D1D43AD52D50B9F511092E1149F@ntserver2.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 23 Jul 2002 19:07:57 +0200
In-Reply-To: Gregory Giguashvili's message of "23 Jul 2002 18:07:51 +0200"
Message-ID: <p73fzyatlsi.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Giguashvili <Gregoryg@ParadigmGeo.com> writes:

> I'm sure that someone has come across this problem and I sure hope there is
> some workaround/patch available. 

Do a F_SETFL lock/unlock on the file  That should act as a full NFS write
barrier and flush all buffers. Best is if you synchronize between the various
writers with the full lock.

-Andi

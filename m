Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163504AbWLGW1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163504AbWLGW1r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 17:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163528AbWLGW1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 17:27:47 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:63757 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163504AbWLGW1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 17:27:46 -0500
From: Hans-Peter Jansen <hpj@urpla.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Mounting NFS root FS
Date: Thu, 7 Dec 2006 23:27:23 +0100
User-Agent: KMail/1.9.5
Cc: "Janne Karhunen" <janne.karhunen@gmail.com>, MrUmunhum@popdial.com
References: <4571CE06.4040800@popdial.com> <24c1515f0612040351p6056101frc12db8eb86063213@mail.gmail.com>
In-Reply-To: <24c1515f0612040351p6056101frc12db8eb86063213@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612072327.24570.hpj@urpla.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:18d01dd0a2a377f0376b761557b5e99a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 4. Dezember 2006 12:51 schrieb Janne Karhunen:
> On 12/2/06, William Estrada <MrUmunhum@popdial.com> wrote:
> > Hi guys,
> >
> >   I have been trying to make FC5's kernel do a boot
> > with an NFS root file system.  I see the support is in the
> > kernel(?).
>
> Is this really properly possible (with read/write access and
> locking in place)? AFAIK NFS client lock state data seems
> to require persistent storage .. ?

Out of curiosity: what's the rational of mounting multiple diskless nodes on 
one rw nfs root filesystem [with locking in place]? 

In my experience, this results in a big mess. I depend heavily on diskless 
setups, where I spent significant time to provide sharing as much data as 
possible between the clients _without_ further interference. The best setup 
I found to get there is using unionfs (which still has issues, mostly due 
to missing/broken mmap support).

Pete

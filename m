Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263030AbVF3T7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263030AbVF3T7G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 15:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263095AbVF3T7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 15:59:05 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:12140 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263030AbVF3Tpk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 15:45:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=ZSDlmdSy5YV9aolIS9582Za/vj7ENaanA6sIFDvXO+CmA1faoqeig/cp7pM6Y4JITre53wolTQfza1BAqyKDEXgYcfILhN15RXweqUT4j1kBzDAbl2A4dH4WXUMWBLtf570fEP6UC0BSqMREQNNqdxDcRufVHTPKlmP/2rtexSs=
Date: Thu, 30 Jun 2005 21:45:20 +0200
From: Diego Calleja <diegocg@gmail.com>
To: mjt@nysv.org (Markus   =?ISO-8859-15?Q?T=F6rnqvist?=)
Cc: nikita@clusterfs.com, doug@mcnaught.org, hubert@uhoreg.ca,
       mrmacman_g4@mac.com, ninja@slaphack.com, Valdis.Kletnieks@vt.edu,
       ltd@cisco.com, gmaxwell@gmail.com, reiser@namesys.com,
       jgarzik@pobox.com, hch@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: reiser4 plugins
Message-Id: <20050630214520.5a939e62.diegocg@gmail.com>
In-Reply-To: <20050630153738.GU11013@nysv.org>
References: <20050629135820.GJ11013@nysv.org>
	<200506291719.j5THJCSg011438@laptop11.inf.utfsm.cl>
	<20050630095926.GN11013@nysv.org>
	<17091.60930.633968.822210@gargle.gargle.HOWL>
	<20050630142107.GQ11013@nysv.org>
	<17092.3415.28856.827179@gargle.gargle.HOWL>
	<20050630153738.GU11013@nysv.org>
X-Mailer: Sylpheed version 2.0.0beta3 (GTK+ 2.6.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 30 Jun 2005 18:37:38 +0300,
mjt@nysv.org (Markus   Törnqvist) escribió:

> If I want to access metadata with bash, do I patch bash to support
> both Gnome's and KDE's solutions? Was there one of XFCE too?
> And FooBarXyzzyWM that'll want to do it's own VFS next year?


The freedesktop people is already designing a common userspace VFS,
take a look at http://freedesktop.org/Software/dvfs . At least it looks like
there'll be a common standard, even if the standard is crappy.

Apparently one of the main reasons for DVFS to exist is "POSIX is not
enought for us". 

This approach  is broken by design, having a second-class VFS separated
from the main VFS (what libc functions see, etc) is wrong, IMO.

The Mockup project (they try to bring a BeOS-like API to linux, I think) is
something similar to DVFS but using FUSE.
Take a look at  http://wiki.mockup.org
(currently down, google cache at
http://66.249.93.104/search?q=cache:OnvclDCpwOwJ:wiki.mockup.org/UserSpaceVFS+mockup+wiki+VFS&hl=es&lr=&client=firefox&strip=1 )

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282692AbRK0Axo>; Mon, 26 Nov 2001 19:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282691AbRK0AxY>; Mon, 26 Nov 2001 19:53:24 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15371 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282690AbRK0AxP>; Mon, 26 Nov 2001 19:53:15 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Journaling pointless with today's hard disks?
Date: 26 Nov 2001 16:52:52 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9tuo54$e8p$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10111261229190.8817-100000@master.linux-ide.org> <0111261535070J.02001@localhost.localdomain> <20011126165920.N730@lynx.no> <9tumf0$dvr$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <9tumf0$dvr$1@cesium.transmeta.com>
By author:    "H. Peter Anvin" <hpa@zytor.com>
In newsgroup: linux.dev.kernel
> 
> Indeed; having explicit write barriers would be a very useful feature,
> but the drives MUST default to strict ordering unless reordering (with
> write barriers) have been enabled explicitly by the OS.
> 

On the subject of write barriers... such a setup probably should have
a serial number field for each write barrier command, and a "WAIT FOR
WRITE BARRIER NUMBER #" command -- which will wait until all writes
preceeding the specified write barrier has been committed to stable
storage.  It might also be worthwhile to have the equivalent
nonblocking operation -- QUERY LAST WRITE BARRIER COMMITTED.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>

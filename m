Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290783AbSBFUUL>; Wed, 6 Feb 2002 15:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290787AbSBFUUB>; Wed, 6 Feb 2002 15:20:01 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58885 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290783AbSBFUTw>; Wed, 6 Feb 2002 15:19:52 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: kernel: ldt allocation failed
Date: 6 Feb 2002 12:19:37 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a3s34p$51o$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0112070057480.20196-100000@tombigbee.pixar.com.suse.lists.linux.kernel> <p73ofj2lpdg.fsf@oldwotan.suse.de> <200202061402.g16E2Nt32223@Port.imtp.ilyichevsk.odessa.ua> <20020206101231.X21624@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020206101231.X21624@devserv.devel.redhat.com>
By author:    Jakub Jelinek <jakub@redhat.com>
In newsgroup: linux.dev.kernel
> 
> Most sane architectures reserve a thread pointer register (%g6 resp. %g7 on
> sparc, tp on ia64, ppc will use %r2, alpha uses a fast pall call as thread
> "register", s390 uses user access register 0 (and s390x uar 0 and 1), etc.).
> On register starved ia32 there aren't too many spare registers, so %gs is
> used instead.
> 

x86-64, interestingly, retains vestigial meaning of the %fs and %gs
registers (but no others) to use as a base pointer for this reason
alone.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>

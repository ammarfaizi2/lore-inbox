Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130180AbQKOUmu>; Wed, 15 Nov 2000 15:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130138AbQKOUmk>; Wed, 15 Nov 2000 15:42:40 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:17674 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130162AbQKOUmb>; Wed, 15 Nov 2000 15:42:31 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: test11-pre5 breaks vmware
Date: 15 Nov 2000 12:12:15 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8uuqmv$el4$1@cesium.transmeta.com>
In-Reply-To: <CF021B54DF0@vcnet.vc.cvut.cz> <Pine.LNX.4.21.0011151454590.10690-100000@godzilla.spiteful.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.21.0011151454590.10690-100000@godzilla.spiteful.org>
By author:    Scott Murray <scott@spiteful.org>
In newsgroup: linux.dev.kernel
> > 
> > Oh. I did not compiled 11-test5, as G450 finally arrived ;-) OK,
> > I'll release patch for vmware, as I cannot stop kernel developers
> > from changing field names :-)
> 
> Actually, I know of at least one other shipping commercial product
> (Sitraka's JProbe Java Profiler) that will require patching because of
> this change.  It seems unwise to be changing field names in commonly
> used /proc files like cpuinfo at this point in time.
> 

The problem with "flags" is that it no longer contains quite the same
information.  Since the semantics of the field changed slightly,
changing the field name is sometimes more correct.

Also, if a piece of software needs raw CPUID information (unlike the
"cooked" one provided by recent kernels) it should use
/dev/cpu/*/cpuid.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

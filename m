Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbTI3UJH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 16:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbTI3UIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 16:08:54 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43783 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261711AbTI3UIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 16:08:50 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
Date: 30 Sep 2003 13:08:21 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <blcnrl$otr$1@cesium.transmeta.com>
References: <20030930073814.GA26649@mail.jlokier.co.uk.suse.lists.linux.kernel> <20030930165450.GF28876@mail.shareable.org.suse.lists.linux.kernel> <20030930172618.GE5507@redhat.com.suse.lists.linux.kernel> <p73pthiyu0e.fsf@oldwotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <p73pthiyu0e.fsf@oldwotan.suse.de>
By author:    Andi Kleen <ak@suse.de>
In newsgroup: linux.dev.kernel
> 
> I implemented it for long mode on x86-64.
> 
> It has to be done before the vesafb is initialized too, otherwise
> you cannot see the error message.
> 
> You could copy the code from arch/x86_64/boot/setup.S 
> (starting with /* check for long mode. */) and change it to
> check for the CPUID bits you want. x86-64 checks a basic collection
> that has been determined to be the base set of x86-64 supporting CPUs.
> But it could be less or more.
> 

Do it in boot/setup.S so that you can still issue a message via the
BIOS.  However, don't forget you might need bug fixes/workarounds like
the P6 SEP in there, too.  From that perspective it would be nice to
have something that can be written in C.  Recent binutils actually
allow gcc-generated .s-files to be assembled for a 16-bit environment
(with lots of overrides.)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbTETV50 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 17:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbTETV50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 17:57:26 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:65292 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261252AbTETV5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 17:57:25 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Recent changes to sysctl.h breaks glibc
Date: 20 May 2003 15:10:08 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bae940$2m5$1@cesium.transmeta.com>
References: <20030519165623.GA983@mars.ravnborg.org> <200305200024.h4K0OnPc025466@turing-police.cc.vt.edu> <m1y9121mdp.fsf@frodo.biederman.org> <200305200111.h4K1BJPc026622@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200305200111.h4K1BJPc026622@turing-police.cc.vt.edu>
By author:    Valdis.Kletnieks@vt.edu
In newsgroup: linux.dev.kernel
> 
> > For a lot of system calls it is actively dangerous to assume dev_t ==
> > __kernel_dev_t.  As glibc does some cute things in there.
> 
> I thought that sort of fun and games was *WHY* userspace can't use the
> kernel headers in the first place?
> 

Indeed.  Because they try to export dev_t, not __kernel_dev_t (unless
you know exactly what you're doing, which most people don't.)

dev_t should be defined by the library ABI, not by the kernel ABI.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbTDUShn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 14:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbTDUShm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 14:37:42 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2064 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261871AbTDUSha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 14:37:30 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] mknod64 with major,minor
Date: 21 Apr 2003 11:49:22 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b81efi$192$1@cesium.transmeta.com>
References: <UTC200304210139.h3L1duq18832.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <UTC200304210139.h3L1duq18832.aeb@smtp.cwi.nl>
By author:    Andries.Brouwer@cwi.nl
In newsgroup: linux.dev.kernel
>
> A second version of mknod64 for i386.
> There are no assumptions on the size of dev_t.
> 
> sys_mknod takes unsigned int (instead of dev_t)
> sys_mknod64 takes two unsigned ints.
> 

Why unsigned int?  If we have a legacy call it should presumably use
the legacy __u16 format.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64

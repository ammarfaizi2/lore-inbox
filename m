Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262722AbTDVBUL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 21:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262764AbTDVBUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 21:20:11 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22792 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262722AbTDVBUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 21:20:10 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] new system call mknod64
Date: 21 Apr 2003 18:32:04 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b8262k$6t8$1@cesium.transmeta.com>
References: <UTC200304220102.h3M126n06187.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <UTC200304220102.h3M126n06187.aeb@smtp.cwi.nl>
By author:    Andries.Brouwer@cwi.nl
In newsgroup: linux.dev.kernel
> 
> Well, I have also done that of course. Both struct and u64 work well.
> Since only kdev_t.h knows about the actual structure of kdev_t
> it is very easy to switch.
> 

The main advantage with making it a struct is that it keep people from
doing stupid stuff like (int)dev where dev is a kdev_t...  There is
all kinds of shit like that in the kernel...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271134AbTGPV5s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 17:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271147AbTGPV5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 17:57:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32519 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S271134AbTGPVzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 17:55:50 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] print_dev_t for 2.6.0-test1-mm
Date: 16 Jul 2003 15:10:19 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bf4igb$mip$1@cesium.transmeta.com>
References: <20030716184609.GA1913@kroah.com> <20030716141320.5bd2a8b3.akpm@osdl.org> <20030716213451.GA1964@win.tue.nl> <20030716143902.4b26be70.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030716143902.4b26be70.akpm@osdl.org>
By author:    Andrew Morton <akpm@osdl.org>
In newsgroup: linux.dev.kernel
>
> Andries Brouwer <aebr@win.tue.nl> wrote:
> >
> > On Wed, Jul 16, 2003 at 02:13:20PM -0700, Andrew Morton wrote:
> > 
> > > The new dev_t encoding is a bit weird because we of course continue to
> > > support the old 8:8 encoding.  I think the rule is: "if the top 32-bits are
> > > zero, it is 8:8, otherwise 32:32".  We can express this nicely with
> > > "%u:%u".
> > 
> > 16-bit only: 8:8, otherwise 32-bit only: 16:16, otherwise 32:32.
> > 
> 
> Why do we need the 16:16 option?
> 

We needs 32-bit for NFSv2, but I thought it was going to be 12:20.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64

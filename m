Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264990AbTGCRPP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 13:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265019AbTGCRPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 13:15:15 -0400
Received: from hank-fep8-0.inet.fi ([194.251.242.203]:52949 "EHLO
	fep08.tmt.tele.fi") by vger.kernel.org with ESMTP id S264990AbTGCRPN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 13:15:13 -0400
Message-ID: <3F04680D.B9703696@pp.inet.fi>
Date: Thu, 03 Jul 2003 20:29:49 +0300
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.2.20aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andries.Brouwer@cwi.nl, akpm@digeo.com, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] cryptoloop
References: <UTC200307021844.h62IiIQ19914.aeb@smtp.cwi.nl>
			<3F0411B9.9E11022D@pp.inet.fi> <20030703082034.5643b336.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jari Ruusu <jari.ruusu@pp.inet.fi> wrote:
> > Andries.Brouwer@cwi.nl wrote:
> > > Changing that would kill all existing modules that use the loop device.
> > >
> > > Maybe nobody cares. Then we can do so in a subsequent patch.
> >
> > I care. Please don't break the transfer function prototype.
> 
> Why?

Because loop-AES attempts to be compatible with structures in loop.h by not
modifying loop.h at all. This is what the "no kernel sources patched or
replaced" means. Breakage in loop.h breaks loop-AES, and I have to clean the
mess.

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>


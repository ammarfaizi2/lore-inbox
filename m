Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266836AbUGLOF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266836AbUGLOF7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 10:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266839AbUGLOF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 10:05:59 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:19650 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S266836AbUGLOF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 10:05:56 -0400
Date: Mon, 12 Jul 2004 16:05:51 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: post 2.6.7 BK change breaks Java?
Message-ID: <20040712140551.GA7264@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <40EEB1B2.7000800@kolivas.org> <Pine.LNX.4.56.0407091954160.22376@jjulnx.backbone.dif.dk> <Pine.LNX.4.56.0407111713420.23979@jjulnx.backbone.dif.dk> <Pine.LNX.4.58.0407111728580.6988@alpha.polcom.net> <Pine.LNX.4.56.0407111735490.23998@jjulnx.backbone.dif.dk> <8A43C34093B3D5119F7D0004AC56F4BC082C7F9D@difpst1a.dif.dk> <40F20372.9000205@quark.didntduck.org> <40F20C23.9050705@quark.didntduck.org> <Pine.LNX.4.56.0407121256270.24702@jjulnx.backbone.dif.dk> <40F28628.2030303@quark.didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F28628.2030303@quark.didntduck.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jul 2004, Brian Gerst wrote:

[a hell of a quote that got snipped]

> >gcc 3.4.0
> >
> >I got a patch from Linus yesterday that seems to fix it nicely on top of
> >2.6.8-rc1. I guess he has his reasons for not CC'ing it to the list, but
> >I've given him feedback on my testing of it, so I hope it'll surface as
> >soon as he's happy with it.
> 
> I see Linus commited a changeset that avoids a tailcall from this 
> function, which messes up the stack if CONFIG_REGPARM=n.  Specifically, 
> it clobbers %edx in the pt_regs image:
> 
> sys_sigaltstack:
>         movl    56(%esp), %eax
>         movl    %eax, 12(%esp)
>         jmp     do_sigaltstack

After a BK pull and a rebuild, Java is well again.

-- 
Matthias Andree

Encrypted mail welcome: my GnuPG key ID is 0x052E7D95 (PGP/MIME preferred)

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbTJ3NuQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 08:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbTJ3NuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 08:50:16 -0500
Received: from chaos.analogic.com ([204.178.40.224]:47503 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262522AbTJ3NuM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 08:50:12 -0500
Date: Thu, 30 Oct 2003 08:51:49 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Sreeram Kumar Ravinoothala <sreeram.ravinoothala@wipro.com>
cc: "Magnus Naeslund(t)" <mag@fbab.net>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: RE: Question on SIGFPE
In-Reply-To: <94F20261551DC141B6B559DC4910867217764F@blr-m3-msg.wipro.com>
Message-ID: <Pine.LNX.4.53.0310300843320.6138@chaos>
References: <94F20261551DC141B6B559DC4910867217764F@blr-m3-msg.wipro.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Oct 2003, Sreeram Kumar Ravinoothala wrote:

>
> Hi Mr Johnson,
> 	Thanks for the mail and sorry for pestering you. Actually the
> call __setfpucw is not visible anywhere. Should I use
>  _FPU_SETCW(cw) instead of that?
>
> Thanks and Regards
> SReeram

Yes. I just looked on a RH-9 system. The stuff I referenced
was probably before there was a Red Hat!

I don't like that MACRO. Hopefully it works. It accesses memory
that may not exist if you do _FPU_SETCW(_FPU_DEFAULT).

For safety do:

fpu_control_t cw = _FPU_DEFAULT;
_FPU_SETCW(cw);


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.



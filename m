Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbVHaP57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbVHaP57 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 11:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbVHaP57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 11:57:59 -0400
Received: from main.gmane.org ([80.91.229.2]:704 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964849AbVHaP56 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 11:57:58 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ed L Cashin <ecashin@coraid.com>
Subject: Re: aoe fails on sparc64
Date: Wed, 31 Aug 2005 11:50:55 -0400
Message-ID: <87vf1mm7fk.fsf@coraid.com>
References: <3afbacad0508310630797f397d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-19-26-204.asm.bellsouth.net
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:n53+jl2Dp7jQ3CelpWHLCs6xadc=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim MacBaine <jmacbaine@gmail.com> writes:

> Hello,
>
> Using aoe on a sparc64 system gives strange results:
>
...
> The log says:
>
> Aug 31 15:18:49 sunny kernel: devfs_mk_dir: invalid argument.<6>
> etherd/e0.0: unknown partition table
> Aug 31 15:18:49 sunny kernel: aoe: 0011d8xxxxxx e0.0 v4000 has
> 67553994410557440
> sectors

OK.  67553994410557440 is 61440 byte swapped in 64 bits, and 30MB is
61440 sectors, so this should be a simple byte order fix.

> The system is an Sun Ultra 5, running 2.6.12.5/sparc64 compiled with
> gcc-3.4.2.  e0.0 is exported on a x86 system using vblade-5, and has a
> size of 30 MB.

Thanks for the report.

-- 
  Ed L Cashin <ecashin@coraid.com>


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272706AbRIGPMZ>; Fri, 7 Sep 2001 11:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272704AbRIGPMP>; Fri, 7 Sep 2001 11:12:15 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39175 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272706AbRIGPL7>; Fri, 7 Sep 2001 11:11:59 -0400
Subject: Re: Recent kernels sound crash  solution found?
To: _deepfire@mail.ru (Samium Gromoff)
Date: Fri, 7 Sep 2001 16:16:12 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <200109071926.f87JQ9l06082@vegae.deep.net> from "Samium Gromoff" at Sep 07, 2001 07:26:08 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15fNMa-0001qL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>       * comment to point 2: very rare circumcistances includes
>    that some time should pass to fragment memory

The alloc_dmap code returns -ENOMEM when the allocation fails. That causes
the open_dmap call to return -ENOMEM which in turn causes DMAbuf_open
to return -ENOMEM which causes audio_openb to return -ENOMEM, which gets
back to userspace. 

I don't see a problem.

[sound btw also supports a module option to keep the dmabuffers allocated
 once and hang onto them]

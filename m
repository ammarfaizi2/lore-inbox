Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316857AbSH0TJ0>; Tue, 27 Aug 2002 15:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316897AbSH0TJ0>; Tue, 27 Aug 2002 15:09:26 -0400
Received: from pD9E23A01.dip.t-dialin.net ([217.226.58.1]:2235 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316857AbSH0TJZ>; Tue, 27 Aug 2002 15:09:25 -0400
Date: Tue, 27 Aug 2002 13:13:37 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: "Peter T. Breuer" <ptb@it.uc3m.es>
cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: block device/VM question
In-Reply-To: <200208271804.g7RI4mc05751@oboe.it.uc3m.es>
Message-ID: <Pine.LNX.4.44.0208271308190.3234-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 27 Aug 2002, Peter T. Breuer wrote:
> Yecch. I have the inode of the sepecial device file. I don't want to
> know the name. I even have a file pointer.

Then you're obviously for the wrong stuff.

> In dentry_open(), we get a struct file f = get_empty_filp(), and then
> fill out various of its fields with enormously obscure things.

For a good reason: we always need to fill in the values somewhere, they 
don't quite come from heaven.

> And for the O_DIRECT flag we seem to do alloc_kiovec(1, &f->f_iobuf).

Perhaps we should go biovec here?

For you, if you can stand it you can even go directly into the dio stuff 
from direct-io.c. You'll just need to know what to do. Or you fill your 
information into some underway function.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-


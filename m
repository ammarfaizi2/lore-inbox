Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266121AbSLTHoZ>; Fri, 20 Dec 2002 02:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266274AbSLTHoZ>; Fri, 20 Dec 2002 02:44:25 -0500
Received: from mail.scram.de ([195.226.127.117]:39380 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S266121AbSLTHoY>;
	Fri, 20 Dec 2002 02:44:24 -0500
Date: Fri, 20 Dec 2002 08:44:15 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@gfrw1044.bocc.de
To: Hannes Reinecke <mail@hannes-reinecke.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.52: compilation fixes for alpha
In-Reply-To: <3E0241C3.4060206@hannes-reinecke.de>
Message-ID: <Pine.LNX.4.44.0212200839320.11457-100000@gfrw1044.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hannes,

> attached are some compilation fixes needed to get the alpha port up and
> running. Note: These fixes are on top of patch-2.5.52-bk3 in the
> 2.5/testing directory, which contain some neccessary fixes regarding
> exception handling.

Is there an additional patch missing?

arch/alpha/mm/extable.c: In function `search_exception_table':
arch/alpha/mm/extable.c:48: `module_list' undeclared (first use in this
function)

This is -bk3 from v2.5/snapshots +your patch (-bk4 +your patch fails to
compile with the same message).

It looks like i386 replaced the loop through module_list by a walk through
extables which is not yet in alpha code.

Thanks,
--jochen


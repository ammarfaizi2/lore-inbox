Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270950AbTGPUhk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 16:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270993AbTGPUhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 16:37:40 -0400
Received: from sponsa.its.UU.SE ([130.238.7.36]:22525 "EHLO sponsa.its.uu.se")
	by vger.kernel.org with ESMTP id S270950AbTGPUhj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 16:37:39 -0400
Date: Wed, 16 Jul 2003 22:52:20 +0200 (MEST)
Message-Id: <200307162052.h6GKqKFQ027503@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: lcapitulino@prefeitura.sp.gov.br, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6-osdl1 compiler error.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Jul 2003 15:12:04 -0300, Luiz Capitulino wrote:
> While trying to compile the 2.6-osdl1 with the 
>''performance-monitoring'' I'm getting this:
>
>CC      drivers/perfctr/init.o
>drivers/perfctr/init.c:19: version.h: No such file or directory

The file drivers/perfctr/version.h is missing, apparently due
to an incomplete merge of the external perfctr package. This
will result in the compilation errors you quoted.

Look at the top of drivers/perfctr/RELEASE-NOTES and you'll see
which version of perfctr OSDL is using, get the corresponding
tarball from http://www.csd.uu.se/~mikpe/linux/perfctr/, and
copy its linux/drivers/perfctr/version.h into your kernel.

You should also file a bug report with the OSDL people.

/Mikael

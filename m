Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271141AbTGXHqK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 03:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271147AbTGXHqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 03:46:09 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:12949 "EHLO phoebee")
	by vger.kernel.org with ESMTP id S271141AbTGXHqG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 03:46:06 -0400
Date: Thu, 24 Jul 2003 10:01:11 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: cijoml@volny.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re: passing my own compiler options into linux kernel compiling
Message-Id: <20030724100111.343d84cd.martin.zwickel@technotrend.de>
In-Reply-To: <200307240916.17530.cijoml@volny.cz>
References: <200307240916.17530.cijoml@volny.cz>
Organization: TechnoTrend AG
X-Mailer: Sylpheed version 0.9.3claws36 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.4.21-rc4 i686 Intel(R) Pentium(R) 4 CPU
 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jul 2003 09:16:17 +0200
Michal Semler <cijoml@volny.cz> bubbled:

> Hello,
> 
> I use gcc-3.3 and I would like compile my kernel with flags:
> 
> -O4 -march=pentium3 -mcpu=pentium3
-O4 is useless. max is -O3

try this file: arch/i386/Makefile
there is something like:

ifdef CONFIG_MPENTIUMIII
CFLAGS += -march=i686
endif

maybe this helps...

Regards,
Martin

-- 
MyExcuse:
Arcserve crashed the server again.

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267281AbTBIPI3>; Sun, 9 Feb 2003 10:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267282AbTBIPI3>; Sun, 9 Feb 2003 10:08:29 -0500
Received: from host194.steeleye.com ([66.206.164.34]:4369 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S267281AbTBIPI1>; Sun, 9 Feb 2003 10:08:27 -0500
Subject: Re: [PATCH][2.5][3/15] smp_call_function/_on_cpu - i386
From: James Bottomley <James.Bottomley@steeleye.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 09 Feb 2003 09:18:05 -0600
Message-Id: <1044803887.1979.39.camel@mulgrave>
Mime-Version: 1.0
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The voyager pieces of this don't provide the smp_call_function_on_cpu(),
since voyager doesn't compile kernel/smp.c, so voyager will break the
first time someone uses the new function.

As a general comment, wouldn't it be better simply to make
smp_call_function an alias for smp_call_function_on_cpu with the mask
being the cpu_online_map?  That way we'd reduce the amount of duplicated
code.

James



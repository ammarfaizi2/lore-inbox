Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbTK1QkL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 11:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbTK1QkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 11:40:11 -0500
Received: from 200-184-71-82.chies.com.br ([200.184.71.82]:28058 "EHLO
	mars.elipse.com.br") by vger.kernel.org with ESMTP id S262655AbTK1QkI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 11:40:08 -0500
Message-ID: <3FC77A59.2090705@elipse.com.br>
Date: Fri, 28 Nov 2003 14:39:53 -0200
From: Felipe W Damasio <felipewd@elipse.com.br>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lista da disciplina de Sistemas Operacionais III 
	<sisopiii-l@cscience.org>
CC: Ricardo Nabinger Sanchez <rnsanchez@terra.com.br>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [SisopIII-l] Re: [PATCH] fix #endif misplacement
References: <20031128141927.5ff1f35a.rnsanchez@terra.com.br> <Pine.LNX.4.53.0311281732100.21904@gockel.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.53.0311281732100.21904@gockel.physik3.uni-rostock.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Nov 2003 16:41:24.0281 (UTC) FILETIME=[75EC3290:01C3B5CE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Tim,

Tim Schmielau wrote:
> No, this is exactly what is intended: don't use the TSC on NUMA, use 
> jiffies instead.

	The patch didn't hurt this.

> Look at the comment just above those lines.

	The patch doesn't uses jiffies indiscriminately: Only if we're on a 
NUMA system with !use_tsc.

	Otherwise (on x86 SMP, for example) we use rdtsc...which seems The 
Right Thing(tm). Hece move the #endif a bit down.

	Cheers

Felipe


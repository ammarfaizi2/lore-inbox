Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268796AbTBZP4n>; Wed, 26 Feb 2003 10:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268786AbTBZPzE>; Wed, 26 Feb 2003 10:55:04 -0500
Received: from franka.aracnet.com ([216.99.193.44]:53432 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268791AbTBZPxw>; Wed, 26 Feb 2003 10:53:52 -0500
Date: Wed, 26 Feb 2003 08:00:50 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>, Dave Jones <davej@codemonkey.org.uk>
cc: schlicht@uni-mannheim.de, torvalds@transmeta.com, hugh@veritas.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5] fix preempt-issues with smp_call_function()
Message-ID: <4210000.1046275248@[10.10.2.4]>
In-Reply-To: <20030226022819.44e1873a.akpm@digeo.com>
References: <200302251908.55097.schlicht@uni-mannheim.de>
 <20030226103742.GA29250@suse.de><20030226015409.78e8e1fb.akpm@digeo.com>
 <20030226111905.GA32415@suse.de> <20030226022819.44e1873a.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> btw, (unrelated) shouldn't smp_call_function be doing magick checks
>> with cpu_online() ?
> 
> Looks OK?  It sprays the IPI out to all the other CPUs in cpu_online_map,
> and waits for num_online_cpus()-1 CPUs to answer.

Incidentally, would be nice if this thing had a timeout and bugged out when
one didn't reply, rather than just wedging the whole CPU for ever. Yes,
it's normally some other bug that makes the other CPU not reply, but would
make diags a damned sight easier.

M.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWGKNyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWGKNyL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 09:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWGKNyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 09:54:11 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:4817 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750792AbWGKNyJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 09:54:09 -0400
Date: Tue, 11 Jul 2006 09:54:30 -0400
From: Mike Grundy <grundym@us.ibm.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Jan Glauber <jan.glauber@de.ibm.com>, linux-kernel@vger.kernel.org,
       systemtap@sources.redhat.com
Subject: Re: [PATCH] kprobes for s390 architecture
Message-ID: <20060711135430.GA5070@localhost.localdomain>
Mail-Followup-To: Heiko Carstens <heiko.carstens@de.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Jan Glauber <jan.glauber@de.ibm.com>, linux-kernel@vger.kernel.org,
	systemtap@sources.redhat.com
References: <20060623150344.GL9446@osiris.boeblingen.de.ibm.com> <OF44DB398C.F7A51098-ON88257196.007CD277-88257196.007DC8F0@us.ibm.com> <20060623222106.GA25410@osiris.ibm.com> <20060624113641.GB10403@osiris.ibm.com> <1151421789.5390.65.camel@localhost> <20060628055857.GA9452@osiris.boeblingen.de.ibm.com> <20060707172333.GA12068@localhost.localdomain> <20060707172555.GA10452@osiris.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060707172555.GA10452@osiris.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2006 at 07:25:55PM +0200, Heiko Carstens wrote:
> > ok, I tried, but my "better ideas" made things worse. stop_machine_run() wins:
> How fast is this if you have to exchange several hundred instructions?

I did a little measuring. On average stop_machine_run() adds 8.7 msec of
overhead on a 4-way config. Of that %57 was sub-msec overhead. For the times
where overhead was measurable, the average was 20.2 msec, lowest at 10msec
highest at 100msec. That's on a z800 under vm and I have no idea how many real
cpus the machine has :-)

-- 
Thanks
Mike

=========================================
Michael Grundy - grundym@us.ibm.com
Advanced Linux Response Team (ALRT)
http://ltc.linux.ibm.com/teamweb/alrt/
845-435-8842 (T/L 295)

If at first you don't succeed, call in an air strike.


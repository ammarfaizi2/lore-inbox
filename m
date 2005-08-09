Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbVHIUWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbVHIUWS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 16:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbVHIUWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 16:22:18 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:31291 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964930AbVHIUWR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 16:22:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gPduQ8XGTsK9oWxm5D43LN/1rRRqMDh1trotTk3EPNWdxa0xlyBKEtMsbwBZ/dx43ukxXxRRp7JSFuaoOMuj4h4+vtC8zU0VNPEso3QRwffFdxnSXEMlLJuiJQeIA8cG9ZmGmJnZo2F+CjpPSsFBFQtZPhSyc3kfj6dD9v/CRrw=
Message-ID: <9268368b05080913226b238879@mail.gmail.com>
Date: Tue, 9 Aug 2005 16:22:16 -0400
From: Daniel Petrini <d.pensator@gmail.com>
To: george@mvista.com
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
Cc: Tony Lindgren <tony@atomide.com>, Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       ck@vds.kolivas.org, tuukka.tikkanen@elektrobit.com,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <42F90C78.60500@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508031559.24704.kernel@kolivas.org>
	 <20050805123754.GA1262@in.ibm.com>
	 <20050808072600.GE28070@atomide.com> <42F90C78.60500@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I convinced my self that the next_timer... code in timer.c misses timers
> (i.e. gives the wrong answer).  I did this (after wondering due to
> performance) by scanning the whole timer list after I had the
> next_timer... answer and finding a better answer, not always, but some
> times.  That code does not address the cascade list correctly.

The timertop kernel patch accounts for all the scheduled timers. Try
to take a look at its output at /proc/top_info. Maybe it can help to
detect it.


Daniel Petrini
-- 
10LE - Linux
INdT - Manaus - Brazil

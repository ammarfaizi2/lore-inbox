Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263854AbTEFPz1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 11:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263852AbTEFPz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 11:55:27 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:22656
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263854AbTEFPym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 11:54:42 -0400
Subject: Re: 2.5.68-mmX: Drowning in irq 7: nobody cared!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: shrybman@sympatico.ca,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030506081716.60de29d1.akpm@digeo.com>
References: <1052141029.2527.27.camel@mars.goatskin.org>
	 <20030505143006.29c0301a.akpm@digeo.com>
	 <1052213733.28797.1.camel@dhcp22.swansea.linux.org.uk>
	 <20030506081716.60de29d1.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052233619.1202.13.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 16:07:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-05-06 at 16:17, Andrew Morton wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> >
> >  With APIC at least it doesnt suprise me the least. The IRQ hack seems
> >  extremely racey.
> 
> Good point.  How about we do something like "if half of the past 1000
> interrupts weren't handled then try to kill the IRQ"?

And if its a sound card generating close pairs of IRQs you might still
trip. It seems the heuristic is more complicated


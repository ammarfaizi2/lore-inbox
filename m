Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265209AbTFZAOj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 20:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265215AbTFZAOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 20:14:39 -0400
Received: from 82-43-130-207.cable.ubr03.mort.blueyonder.co.uk ([82.43.130.207]:37343
	"EHLO efix.biz") by vger.kernel.org with ESMTP id S265209AbTFZAOh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 20:14:37 -0400
Subject: Re: AMD MP, SMP, Tyan 2466
From: Edward Tandi <ed@efix.biz>
To: Timothy Miller <miller@techsource.com>
Cc: joe briggs <jbriggs@briggsmedia.com>,
       Artur Jasowicz <kernel@mousebusiness.com>,
       Brian Jackson <brian@brianandsara.net>,
       Bart SCHELSTRAETE <Bart.SCHELSTRAETE@dhl.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <3EFA32C6.5030303@techsource.com>
References: <BB1F47F5.17533%kernel@mousebusiness.com>
	 <200306251501.14207.jbriggs@briggsmedia.com>
	 <1056567378.31260.9.camel@wires.home.biz> <3EFA2939.2060005@techsource.com>
	 <1056583075.31265.22.camel@wires.home.biz>
	 <3EFA2F97.5000705@techsource.com>  <3EFA32C6.5030303@techsource.com>
Content-Type: text/plain
Message-Id: <1056587355.10295.52.camel@wires.home.biz>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 26 Jun 2003 01:29:16 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-26 at 00:39, Timothy Miller wrote:
> Timothy Miller wrote:
> 
> > It is my understanding that the registered memory requirement has 
> > nothing to do with SMP but instead with the amount of memory you have. 
> > The more memory chips you have, the greater the signal loading on the 
> > memory bus.  More input drivers means more capacitance which means you 
> > need your output drivers to put out data sooner (relative to the clock 
> > edge, so registered delays by one clock) and stronger (greater drive 
> > strength).
> >
> > In an SMP system (besides NUMA), multiple processors will talk to the 
> > same memory through a shared memory controller (like in a Northbridge), 
> > so although there are multiple processors, there is still only one 
> > memory bus.  Pulling off one CPU isn't going to change that situation.
> > 
> Here's a URL:
> 
> http://www.simmtester.com/PAGE/memory/memfaq.asp?cat=6&subcat=&tableView=detail&faqId=15

It does seem a bit out of date talking about PC100. But I found another
source of information:

http://www.memorysuppliers.com/memoryterms.html

Registered Memory
        SDRAM memory that contains registers directly on the module. The
        registers re-drive the signals through the memory chips and
        allow the module to be built with more memory chips. Registered
        and unbuffered memory cannot be mixed. The design of the
        computer memory controller dictates which type of memory the
        computer requires. 

Regarding the last sentence, the Tyan 2466 appears to be able to support
unbuffered memory in slots 1 and 2 only (and the type cannot be mixed of
course). The earlier 2460 doesn't allow anything but registered.

Ed-T.



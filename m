Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262801AbTJJOfg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 10:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbTJJOfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 10:35:36 -0400
Received: from vega.digitel2002.hu ([213.163.0.181]:52880 "HELO lgb.hu")
	by vger.kernel.org with SMTP id S262801AbTJJOfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 10:35:32 -0400
Date: Fri, 10 Oct 2003 16:35:29 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: Stuart Longland <stuartl@longlandclan.hopto.org>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, Fabian.Frederick@prov-liege.be,
       linux-kernel@vger.kernel.org
Subject: Re: 2.7 thoughts
Message-ID: <20031010143529.GT5112@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
References: <D9B4591FDBACD411B01E00508BB33C1B01F13BCE@mesadm.epl.prov-liege.be> <20031009115809.GE8370@vega.digitel2002.hu> <20031009165723.43ae9cb5.skraw@ithnet.com> <3F864F82.4050509@longlandclan.hopto.org> <20031010125137.4080a13b.skraw@ithnet.com> <3F86BD0E.4060607@longlandclan.hopto.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3F86BD0E.4060607@longlandclan.hopto.org>
X-Operating-System: vega Linux 2.6.0-test7 i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 11, 2003 at 12:07:10AM +1000, Stuart Longland wrote:
> Oh, okay, this sort of thing is supported by industrial boxes? 
> Interesting... Live and learn I spose ;-) (You're right, I'm not 
> familiar with industrial boxes at all.  My experience is with mostly 
> desktop computers, laptops, and some entry-level servers)
> 
> Hotplug RAM I could see would be possible, but hotplug CPUs?  I spose if 
> you've got a multiprocessor box, you could swap them one at a time, but 
> my thinking is that this would cause issues with the OS as it wouldn't 
> be expecting the CPU to suddenly disappear.  Problems would be even 

Why? Sure, you should note OS before unplug a CPU ;-) but in this case OS
should be noticed that it could not use that CPU any more (like scheduler,
interrupt delivering etc). And then it's not an issue if you unplug THAT
cpu. Sure, some hw supporting is needed, a "normal" motherboard does not
like to unplug a CPU when powered of course by hardware issues, but "CPU
hotplug capable" motherboards can support this. Maybe of course some notice
mechanism is needed for the motherboard as well not only for the OS, but it
only mean that notfication before unplugging the CPU should be delivered to
the OS _and_ to the hardware. Sure, I have no experience at all in this
area, so this is only a theory (I've never see a hardware support this yet).

> worse if the old and new CPUs were of different types too.

Yes this IS an issue. I think this is no good workaround for this problem,
but I also don't think that this situation is well supported by other
OSes as well ... If you insert a new CPU which is fully compatible with
the old one this should not be an issue however.

- Gábor (larta'H)

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277041AbRJHR4U>; Mon, 8 Oct 2001 13:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277044AbRJHR4K>; Mon, 8 Oct 2001 13:56:10 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:29700 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S277041AbRJHRzu>; Mon, 8 Oct 2001 13:55:50 -0400
Date: Mon, 8 Oct 2001 13:56:20 -0400
Message-Id: <200110081756.f98HuKs10699@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.11-pre4 remove spurious kernel recompiles 
X-Newsgroups: linux.dev.kernel
In-Reply-To: <32255.1002504844@kao2.melbourne.sgi.com>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <32255.1002504844@kao2.melbourne.sgi.com> kaos@ocs.com.au wrote:

| concentrating on correctness for kbuild 2.5.  MEC mantra:
| 
|   Correctness comes first. 
|   Then maintainability. 
|   Then speed.

  Sounds wrong to me... maintainability is done best at design time,
with modularity and by making things table driven where it makes sense.
Unless you hack at it until it works, then start with a new design to
implement what you learned, maintainability is better "built in not
added on" as the commercial says. Correctness is both a design and
implementation issue, of course.

  If you design to be maintainable then correctness and speed are easier
to achieve because changes are easier and have fewer side effects.

  As an example, the recent VM wars center on trying to see what works
badly and fixing it, rather than being a complete rewrite from scratch
of what has been learned and how to apply it. If the original design
had been made for easy changes, say by putting all the code in a
module, you could have a range of VM modules and a single source tree,
with options selected at boot time, perhaps.

  I sense that there are many thoughts on dispatching as well, another
place where theories could be put into modules. Perhaps in 2.5?

-- 
bill davidsen <davidsen@tmr.com>
 "If I were a diplomat, in the best case I'd go hungry.  In the worst
  case, people would die."
		-- Robert Lipe

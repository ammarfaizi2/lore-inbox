Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262860AbTJJO7Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 10:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262865AbTJJO7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 10:59:25 -0400
Received: from holomorphy.com ([66.224.33.161]:15489 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262860AbTJJO7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 10:59:23 -0400
Date: Fri, 10 Oct 2003 08:01:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: G?bor L?n?rt <lgb@lgb.hu>,
       Stuart Longland <stuartl@longlandclan.hopto.org>,
       Stephan von Krawczynski <skraw@ithnet.com>,
       Fabian.Frederick@prov-liege.be, linux-kernel@vger.kernel.org
Subject: Re: 2.7 thoughts
Message-ID: <20031010150122.GD727@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Mark Mielke <mark@mark.mielke.cc>, G?bor L?n?rt <lgb@lgb.hu>,
	Stuart Longland <stuartl@longlandclan.hopto.org>,
	Stephan von Krawczynski <skraw@ithnet.com>,
	Fabian.Frederick@prov-liege.be, linux-kernel@vger.kernel.org
References: <D9B4591FDBACD411B01E00508BB33C1B01F13BCE@mesadm.epl.prov-liege.be> <20031009115809.GE8370@vega.digitel2002.hu> <20031009165723.43ae9cb5.skraw@ithnet.com> <3F864F82.4050509@longlandclan.hopto.org> <20031010125137.4080a13b.skraw@ithnet.com> <3F86BD0E.4060607@longlandclan.hopto.org> <20031010143529.GT5112@vega.digitel2002.hu> <20031010144723.GC727@holomorphy.com> <20031010144837.GB12134@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031010144837.GB12134@mark.mielke.cc>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 10:48:37AM -0400, Mark Mielke wrote:
> Perhaps I've naive here, but - with hot-pluggable CPU machines, do you not
> de-activate the CPU through software first, before pulling the CPU out, at
> which point it is not in use?

Well, you deleted my reply, but never mind that.

This obviously can't work unless the kernel gets some kind of warning.
Userspace and kernel register state, once lost that way, can't be
recovered, and if tasks are automatically suspended (e.g. cpu dumps to
somewhere and a miracle occurs), you'll deadlock if the kernel was in
a non-preemptible critical section at the time.

What I suspect to be the case is some kind of warning is given to the
kernel, and it has to respond within a certain time. Apparently it
succeeds most of the time despite my naysaying if this actually works.


-- wli

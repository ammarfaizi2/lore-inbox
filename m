Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261435AbSJ1Rru>; Mon, 28 Oct 2002 12:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261429AbSJ1Rr2>; Mon, 28 Oct 2002 12:47:28 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:43683 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261435AbSJ1Rej>;
	Mon, 28 Oct 2002 12:34:39 -0500
Date: Mon, 28 Oct 2002 09:35:37 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>
cc: Michael Hohnbaum <hohnbaum@us.ibm.com>, mingo@redhat.com,
       habanero@us.ibm.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: NUMA scheduler  (was: 2.5 merge candidate list 1.5)
Message-ID: <535130000.1035826537@flay>
In-Reply-To: <200210281826.37451.efocht@ess.nec.de>
References: <200210280132.33624.efocht@ess.nec.de> <200210281734.41115.efocht@ess.nec.de> <524720000.1035824241@flay> <200210281826.37451.efocht@ess.nec.de>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm puzzled about the initial load balancing impact and have to think
> about the results I've seen from you so far... In the environments I am
> used to, the frequency of exec syscalls is rather low, therefore I didn't
> care too much about the sched_balance_exec performance and prefered to
> try harder to achieve good distribution across the nodes.

OK, but take a look at Michael's second patch. It still looks at
nr_running on every queue in the system (with some slightly strange
code to make a rotating choice on nodes on the case of equality),
so should still be able to make the best decision .... *but* it
seems to be much cheaper to execute. Not sure why at this point,
given the last results I sent you last night ;-)

M.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261276AbSJ1XnE>; Mon, 28 Oct 2002 18:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261283AbSJ1XnE>; Mon, 28 Oct 2002 18:43:04 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:31372 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S261276AbSJ1XnD> convert rfc822-to-8bit; Mon, 28 Oct 2002 18:43:03 -0500
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: NUMA scheduler  (was: 2.5 merge candidate list 1.5)
Date: Tue, 29 Oct 2002 00:49:08 +0100
User-Agent: KMail/1.4.1
Cc: Michael Hohnbaum <hohnbaum@us.ibm.com>, mingo@redhat.com,
       habanero@us.ibm.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
References: <200210280132.33624.efocht@ess.nec.de> <200210281838.44556.efocht@ess.nec.de> <536200000.1035826605@flay>
In-Reply-To: <536200000.1035826605@flay>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210290049.08582.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 October 2002 18:36, Martin J. Bligh wrote:
> >> Schedbench 4:
> >>                              Elapsed   TotalUser    TotalSys     AvgUser
> >>               2.5.44-mm4       32.45       49.47      129.86        0.82
> >>       2.5.44-mm4-focht-1       38.61       45.15      154.48        1.06
> >>       2.5.44-mm4-hbaum-1       37.81       46.44      151.26        0.78
> >>      2.5.44-mm4-focht-12       23.23       38.87       92.99        0.85
> >>      2.5.44-mm4-hbaum-12       22.26       34.70       89.09        0.70
> >>         2.5.44-mm4-f1-h2       21.39       35.97       85.57        0.81
> >
> > One more remarks:
> > You seem to have made the numa_test shorter. That reduces it to beeing
> > simply a check for the initial load balancing as the hackbench running in
> > the background (and aimed to disturb the initial load balancing) might
> > start too late. You will most probably not see the impact of node
> > affinity with such short running tests. But we weren't talking about node
> > affinity, yet...
>
> I didn't modify what you sent me at all ... perhaps my machine is
> just faster than yours?
>
> /me ducks & runs ;-)

:-)))

I tried with IA32, too ;-) With PROBLEMSIZE=1000000 I get on a 2.8GHz
XEON something around 16s. On a 1.6GHz Athlon it's 22s. Both times running
./numa_test 2 on a dual CPU box. The usertime is pretty independent of the
OS, (but the scheduling influences it a lot).

But: you have a node level cache! Maybe the whole memory is inside that
one and then things can go really fast. Hmmm, I guess I'll need some
cache detection in the future to enforce that the BM really runs in
memory... Increasing PROBLEMSIZE might help, but we can do that later,
when testing affinity (I'm not giving up on this idea... ;-)

Regards,
Erich


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280624AbRKSTJh>; Mon, 19 Nov 2001 14:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280625AbRKSTJ1>; Mon, 19 Nov 2001 14:09:27 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:14768 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S280624AbRKSTJO>; Mon, 19 Nov 2001 14:09:14 -0500
Date: Mon, 19 Nov 2001 11:07:25 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Andi Kleen <ak@suse.de>, Davide Libenzi <davidel@xmailserver.org>,
        lse-tech@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: Real Time Runqueue
Message-ID: <20011119110725.D1144@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <20011116154701.G1152@w-mikek2.des.beaverton.ibm.com> <Pine.LNX.4.40.0111161620050.998-100000@blue1.dev.mcafeelabs.com> <20011116163224.H1152@w-mikek2.des.beaverton.ibm.com> <20011119173022.A19740@wotan.suse.de> <200111191823.fAJINNb30280@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200111191823.fAJINNb30280@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Mon, Nov 19, 2001 at 11:23:23AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2001 at 11:23:23AM -0700, Richard Gooch wrote:
> 
> We have to continue providing global RT semantics. However, a
> non-privileged scheduling class which gives RT-like behaviour within a
> scheduling group would be *great*! I've wished for such a facility
> myself.
> 

If we go to the trouble of supporting scheduling groups, then it would
seem that one could define a 'global RT' group for any required global
semantics.  The initial development costs (scheduling groups) may be
high, but you would get global RT semantics for free.  I also believe
that we may be able to keep the overhead out of scheduling decisions for
tasks not in the groups.  My only concern would be with groups that
span multiple CPUs (such as the global one).  If the scheduler continues
to use a single lock (which I don't advocate), this is not much of an
issue.  However, things can get quite complicated with multiple (per-CPU)
locks and the possibly required per-group synchronization items.

-- 
Mike

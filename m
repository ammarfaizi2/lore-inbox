Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262717AbSI1FSs>; Sat, 28 Sep 2002 01:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262718AbSI1FSs>; Sat, 28 Sep 2002 01:18:48 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:22780 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262717AbSI1FSs>; Sat, 28 Sep 2002 01:18:48 -0400
Date: Sat, 28 Sep 2002 10:59:40 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.38-mm3
Message-ID: <20020928105940.A32125@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20020928043655.GU3530@holomorphy.com> <Pine.LNX.4.44.0209280053590.32347-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209280053590.32347-100000@montezuma.mastecende.com>; from zwane@linuxpower.ca on Sat, Sep 28, 2002 at 12:54:39AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2002 at 12:54:39AM -0400, Zwane Mwaikambo wrote:
> On Fri, 27 Sep 2002, William Lee Irwin III wrote:
> 
> > On Sat, Sep 28, 2002 at 12:35:30AM -0400, Zwane Mwaikambo wrote:
> > > Mine is a UP box not an SMP kernel, although preempt is enabled;
> > > 0xc013d370 <fget>:      push   %ebx
> > > 0xc013d371 <fget+1>:    mov    %eax,%ecx
> > > 0xc013d373 <fget+3>:    mov    $0xffffe000,%edx
> > > 0xc013d378 <fget+8>:    and    %esp,%edx
> > > 0xc013d37a <fget+10>:   incl   0x4(%edx)
> > 
> > Do you have instruction-level profiles to show where the cost is on UP?
> 
> Unfortunately no, i was lucky to remember to even be running profile=n on 
> this box.

That is sufficient to get instruction level profile. Just use 
the hacked readprofile by tridge (it's available somewhere in his
samba.org webpage).

I suspect that inlining fget() will help, not sure whether that is
clean code-wise.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.

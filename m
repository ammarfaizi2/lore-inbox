Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317777AbSGZPr6>; Fri, 26 Jul 2002 11:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317785AbSGZPr6>; Fri, 26 Jul 2002 11:47:58 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:63985 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317777AbSGZPru>; Fri, 26 Jul 2002 11:47:50 -0400
Date: Fri, 26 Jul 2002 21:24:51 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Ravikiran G Thirumalai <kiran@in.ibm.com>, linux-kernel@vger.kernel.org,
       lse <lse-tech@lists.sourceforge.net>,
       Richard J Moore <richardj_moore@uk.ibm.com>, masonmik@us.ibm.com
Subject: Re: [Lse-tech] Re: [RFC] Scalable statistics counters using kmalloc_percpu
Message-ID: <20020726212451.A19119@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20020726204033.D18570@in.ibm.com> <Pine.LNX.4.44L.0207261225160.3086-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44L.0207261225160.3086-100000@imladris.surriel.com>; from riel@conectiva.com.br on Fri, Jul 26, 2002 at 12:27:40PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2002 at 12:27:40PM -0300, Rik van Riel wrote:
> On Fri, 26 Jul 2002, Ravikiran G Thirumalai wrote:
> 
> > Rik, You were interested in using this.  Does this implementation suit
> > your needs?
> 
> >From a quick glance it looks like it will.
> 
> However, it might be more efficient to put the statistics
> in one file in /proc with named fields, or have a way to
> group them in one or multiple files.
> 
> Not sure about that, though ... really depends on how
> expensive stat+open+read+close is compared to parsing a
> file with multiple fields.

Hi Rik,

It seems that either way it might not have the scalability
required for system monitoring software that needs faster
access. One of the possibilities is to see if they can be
mapped to user space, but that requires significant chage
in the percpu allocator. Does this seem like a logical next
step for exploration to you ?

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.

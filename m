Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030449AbWFITcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030449AbWFITcu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 15:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030451AbWFITcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 15:32:50 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:65469 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030449AbWFITct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 15:32:49 -0400
Subject: Re: Idea about a disc backed ram filesystem
From: Lee Revell <rlrevell@joe-job.com>
To: Matheus Izvekov <mizvekov@gmail.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Sascha Nitsch <Sash_lkl@linuxhowtos.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <305c16960606091227w7e62003bhef576fb07d0aa95@mail.gmail.com>
References: <mizvekov@gmail.com>
	 <305c16960606082159v2dc588abo6359d87173327c83@mail.gmail.com>
	 <200606091343.k59DhC1f004434@laptop11.inf.utfsm.cl>
	 <305c16960606090807g6372b69dy3167b0e191b2c113@mail.gmail.com>
	 <1149878633.3894.224.camel@mindpipe>
	 <305c16960606091227w7e62003bhef576fb07d0aa95@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 09 Jun 2006 15:31:43 -0400
Message-Id: <1149881504.3894.250.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-09 at 16:27 -0300, Matheus Izvekov wrote:
> On 6/9/06, Lee Revell <rlrevell@joe-job.com> wrote:
> > On Fri, 2006-06-09 at 12:07 -0300, Matheus Izvekov wrote:
> > > Ok, but reality is that, even if i setup a swap partition with the
> > > most lazy swapiness, it will swap my processes out. Is there a
> > > pratical way to pin all processes to ram or otherwise tell the vm to
> > > never swap any process? If there is, then you are right, there is no
> > > point in doing this.
> > >
> >
> > echo 0 > /proc/sys/vm/swappiness
> >
> > Lee
> 
> Sorry, i took a look at the code which handles this and swappiness = 0
> doesnt seem to imply that process memory will never be swapped out.
> 

OK, then use mlockall().

Lee


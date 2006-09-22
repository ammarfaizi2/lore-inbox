Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWIVAGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWIVAGp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 20:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWIVAGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 20:06:45 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:36805 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932126AbWIVAGo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 20:06:44 -0400
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Paul Menage <menage@google.com>
Cc: npiggin@suse.de, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Paul Jackson <pj@sgi.com>,
       rohitseth@google.com, devel@openvz.org, clameter@sgi.com
In-Reply-To: <6599ad830609211509x17f0306qbe6d0ef86b86cbc9@mail.google.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609201252030.32409@schroedinger.engr.sgi.com>
	 <1158798715.6536.115.camel@linuxchandra>
	 <20060920173638.370e774a.pj@sgi.com>
	 <6599ad830609201742h71d112f4tae8fe390cb874c0b@mail.google.com>
	 <1158803120.6536.139.camel@linuxchandra>
	 <6599ad830609201852k12cee6eey9086247c9bdec8b@mail.google.com>
	 <1158869186.6536.205.camel@linuxchandra>
	 <6599ad830609211310s4e036e55h89bab26432d83c11@mail.google.com>
	 <1158875062.6536.210.camel@linuxchandra>
	 <6599ad830609211509x17f0306qbe6d0ef86b86cbc9@mail.google.com>
Content-Type: text/plain
Organization: IBM
Date: Thu, 21 Sep 2006 17:06:40 -0700
Message-Id: <1158883601.6536.223.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-21 at 15:09 -0700, Paul Menage wrote:
> On 9/21/06, Chandra Seetharaman <sekharan@us.ibm.com> wrote:
> >
> > >
> > > But, there's no reason that the OpenVZ resource control mechanisms
> > > couldn't be hooked into a generic process container mechanism along
> > > with cpusets and RG.
> >
> > Isn't that one of the things we are trying to avoid (each one having
> > their own solution, especially when we _can_ have a common solution).
> 
> Can we actually have a single common solution that works for everyone,
> no matter what their needs? It's already apparent that there are
> multiple different and subtly incompatible definitions of what "memory
> controller" means and needs to do. Maybe these can be resolved - but
> maybe it's better to have, say, two simple but very different memory
> controllers that the user can pick between, rather than one big and
> complicated one that tries to please everyone.

Paul,

Think about what will be available to customer through a distro. 

There are two (competing) memory controllers in the kernel. But, distro
can turn only one ON. Which in turn mean
 - there will be a debate from the two controller users/advocates with
   the distro (headache to distro) about which one to turn ON
 - one party will _not_ get what they want and hence no point in them 
   getting the feature into the mainline in the first place 
   (dissatisfaction of the users/original implementors of one solution).

So, IMHO, it is better to sort out the differences before we get things
in mainline kernel.
 
> 
> Paul
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------



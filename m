Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277265AbRJJP2S>; Wed, 10 Oct 2001 11:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277272AbRJJP17>; Wed, 10 Oct 2001 11:27:59 -0400
Received: from hq2.fsmlabs.com ([209.155.42.199]:28935 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S277271AbRJJP1s>;
	Wed, 10 Oct 2001 11:27:48 -0400
Date: Wed, 10 Oct 2001 09:23:00 -0600
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: BALBIR SINGH <balbir.singh@wipro.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with insertion
Message-ID: <20011010092300.A8389@hq2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BC3E424.1070901@wipro.com>
User-Agent: Mutt/1.3.18i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 11:31:08AM +0530, BALBIR SINGH wrote:
> Linus Torvalds wrote:
> >I can't think of many lists like that. The PCI lists certainly are both
> >add/remove: cardbus bridges and hotplug-PCI means that they are not just
> >purely "enumerate at bootup".
> >
> 
> I agree, I just thought of one case quickly. Assume that somebody did a cat /proc/pci.
> Meanwhile somebody is adding a new pci device (hotplug PCI) simultaneously (which is very rare).
> I would not care if the new device showed up in the output of /proc/pci this time. It would
> definitely show up next time. Meanwhile locking the list (just in case it changes) is an
> overhead in the case above. I was referring to these cases in my earlier mail.

So you make the data structure and algorithms more complex and hard to maintain in
order to get an undetectable improvement in the speed of something that almost
never happens and and that is not even in the same neighborhood as being a 
bottleneck?




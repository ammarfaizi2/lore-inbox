Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291854AbSBARHp>; Fri, 1 Feb 2002 12:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291857AbSBARHh>; Fri, 1 Feb 2002 12:07:37 -0500
Received: from ns.caldera.de ([212.34.180.1]:52117 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S291854AbSBARH1>;
	Fri, 1 Feb 2002 12:07:27 -0500
Date: Fri, 1 Feb 2002 18:07:21 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] kthread abstraction
Message-ID: <20020201180721.A6623@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20020201163818.A32551@caldera.de.suse.lists.linux.kernel> <p73d6zpno2u.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <p73d6zpno2u.fsf@oldwotan.suse.de>; from ak@suse.de on Fri, Feb 01, 2002 at 05:50:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 05:50:33PM +0100, Andi Kleen wrote:
> Christoph Hellwig <hch@caldera.de> writes:
> 
> 	
> >     void *data;
> > 
> > 	Opaque data for the thread's use.
> 
> That requires to dynamically allocate and initialize kthread if you
> can have potentially multiple threads (= too much to write) 
> 
> I think it would be better to pass data as a separate argument.
> You can put the kthread and the data into a private structure on
> the stack, pass the address of it to kernel_thread and wait until the 
> thread has read it using a completion. 

Agreed.  I will rework the patch to follow your suggestion.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.

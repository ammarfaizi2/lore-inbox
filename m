Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbUKSQN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbUKSQN3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 11:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbUKSQNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 11:13:23 -0500
Received: from fsmlabs.com ([168.103.115.128]:2240 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261473AbUKSQMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 11:12:14 -0500
Date: Fri, 19 Nov 2004 09:11:23 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: Andi Kleen <ak@suse.de>,
       "kernel-stuff@comcast.net" <kernel-stuff@comcast.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: X86_64: Many Lost ticks
In-Reply-To: <200411190322_MC3-1-8EFA-5B2@compuserve.com>
Message-ID: <Pine.LNX.4.61.0411190909530.7201@musoma.fsmlabs.com>
References: <200411190322_MC3-1-8EFA-5B2@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Nov 2004, Chuck Ebbert wrote:

> On Thu, 18 Nov 2004 at 19:50:32 +0100, Andi Kleen wrote:
> 
> > On Thu, Nov 18, 2004 at 05:10:17PM +0000, Alan Cox wrote:
> >
> > > Ok ACPI timer override probably goes back into the broken bucket and out
> > > of -ac in -ac11 then.
> >
> > The timer override should be fine (I have confirmation from Nvidia
> > about this). The only thing that you can take out if you're conservative
> > is the change to not disable the IOAPIC by default when Nvidia 
> > is detected (in check_ioapic()) 
> 
> 
> I did that long ago; the below patch is dated Oct 28 on my fileserver.
> 
> Alan could save himself some work if we shared patches... I already
> backported even more of the networking stuff to 2.6.9 than he did.

The thing is, without the IOAPIC enable it's essentially a no operation 
since i8259 mode wouldn't use the pin information.


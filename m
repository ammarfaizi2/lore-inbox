Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWIID3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWIID3H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 23:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWIID3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 23:29:07 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50343 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932107AbWIID3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 23:29:04 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: Brandon Philips <brandon@ifup.org>, linux-kernel@vger.kernel.org,
       Brice Goglin <brice@myri.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       Robert Love <rml@novell.com>
Subject: Re: 2.6.18-rc6-mm1 2.6.18-rc5-mm1 Kernel Panic on X60s
References: <20060908174437.GA5926@plankton.ifup.org>
	<20060908121319.11a5dbb0.akpm@osdl.org>
	<20060908194300.GA5901@plankton.ifup.org>
	<20060908125053.c31b76e9.akpm@osdl.org>
Date: Fri, 08 Sep 2006 21:27:46 -0600
In-Reply-To: <20060908125053.c31b76e9.akpm@osdl.org> (Andrew Morton's message
	of "Fri, 8 Sep 2006 12:50:53 -0700")
Message-ID: <m1slj1iurx.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Fri, 8 Sep 2006 14:43:00 -0500
> Brandon Philips <brandon@ifup.org> wrote:
>
>> On 12:13 Fri 08 Sep 2006, Andrew Morton wrote:
>> > On Fri, 8 Sep 2006 12:44:37 -0500
>> > Brandon Philips <brandon@ifup.org> wrote:
>> > > 2.6.18-rc4-mm3 boots ok.
>> > > 
>> > > I will try and bisect the problem later tonight-
>> > 
>> > Thanks.  First, try disabling CONFIG_PCI_MSI.
>> 
>> With CONFIG_PCI_MSI disabled the system boots.  
>
> OK, thanks.
>
> So likely candidates are:
>
> - Brice's MSI changes
>
> - The conversion of i386 to use the genirq code
>
> - Eric's MSI/genirq changes
>
> or a combination of the above.  Or something else.
>
> <adds ccs, steps back expectantly>

Thanks for the heads up.

There was another panic reported last -mm tree I believe as well.

Eric

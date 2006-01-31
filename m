Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030300AbWAaD2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbWAaD2w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 22:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWAaD2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 22:28:51 -0500
Received: from 66.239.25.20.ptr.us.xo.net ([66.239.25.20]:31887 "EHLO
	zoot.lnxi.com") by vger.kernel.org with ESMTP id S1030300AbWAaD2v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 22:28:51 -0500
To: Doug Thompson <norsk5@yahoo.com>
Cc: Dave Jones <davej@redhat.com>, Alan Cox <alan@redhat.com>,
       "bluesmoke-devel@lists.sourceforge.net" 
	<bluesmoke-devel@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: noisy edac
References: <20060130185931.71975.qmail@web50112.mail.yahoo.com>
From: ebiederman@lnxi.com (Eric W. Biederman)
Date: Mon, 30 Jan 2006 20:28:37 -0700
In-Reply-To: <20060130185931.71975.qmail@web50112.mail.yahoo.com> (Doug
 Thompson's message of "Mon, 30 Jan 2006 10:59:31 -0800 (PST)")
Message-ID: <m3vew1jct6.fsf@maxwell.lnxi.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Thompson <norsk5@yahoo.com> writes:

> that driver should be refactored to only output NON-FATALs with debug turned on.

We need to root cause this before that decision is made.

> --- Dave Jones <davej@redhat.com> wrote:
>
>> On Sun, Jan 29, 2006 at 04:52:06PM -0500, Alan Cox wrote:
>>  > On Thu, Jan 26, 2006 at 08:41:05PM -0500, Dave Jones wrote:
>>  > > e752x_edac is very noisy on my PCIE system..
>>  > > my dmesg is filled with these...
>>  > > 
>>  > > [91671.488379] Non-Fatal Error PCI Express B
>>  > > [91671.492468] Non-Fatal Error PCI Express B
>>  > > [91901.100576] Non-Fatal Error PCI Express B
>>  > > [91901.104675] Non-Fatal Error PCI Express B
>>  > 
>>  > Pre-production system or final release ?
>> 
>> Currently shipping Dell Precision 470.
>> 

Actually I remember something very weird with this error.
I think the Non-Fatal was some weird designation by Intel,
that came right out of the data sheet but didn't have a useful
interpretation.

I suspect that you have an actual hardware problem there.
Quite possibly that a riser or card is not plugged in all of
the way.

As I recall most of the checks clear the error bit when they
detect the error so the fact that it is reoccurring suggests
that the error is reoccurring this frequently.

So before we go off and give up and interpreting this error
can we please root cause at least what the driver is doing?

It has been about a year since I saw something like this and
someone else was tracking the error but I seem to remember
an error message like this resulting from  an actual fixable problem.

Eric



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWBOUOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWBOUOD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 15:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWBOUOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 15:14:03 -0500
Received: from uproxy.gmail.com ([66.249.92.205]:51137 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751277AbWBOUOB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 15:14:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GFEazbgSk9xS1qmMpAimZrbmWeqGxu0ifjsc695Q7ODxpvVfzlr2h6uSyyrQcjfFApq/ckOvZE7L97ylZ9fnC4FU4/qLKi3orVztkTcaaH6bKpxMScMDcmkE3upfO5w0ijG0H3sV3pYcAsB6ElpZ+9XxVfgIiBRkblhb7Kz/LfM=
Message-ID: <69304d110602151213r1facd508idd859c8cff0326a7@mail.gmail.com>
Date: Wed, 15 Feb 2006 21:13:59 +0100
From: Antonio Vargas <windenntw@gmail.com>
To: Andi Kleen <ak@suse.de>, Christopher Friesen <cfriesen@nortel.com>,
       Ulrich Drepper <drepper@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>,
       David Singleton <dsingleton@mvista.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/5] lightweight robust futexes: -V1
In-Reply-To: <200602152102.12795.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060215151711.GA31569@elte.hu> <200602151942.20494.ak@suse.de>
	 <43F385C1.9020508@nortel.com> <200602152102.12795.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/06, Andi Kleen <ak@suse.de> wrote:
> On Wednesday 15 February 2006 20:49, Christopher Friesen wrote:
>
> > The goal is for the kernel to unlock the mutex, but the next task to
> > aquire it gets some special notification that the status is unknown.  At
> > that point the task can either validate/clean up the data and reset the
> > mutex to clean (if it can) or it can give up the mutex and pass it on to
> > some other task that does know how to validate/clean up.
>
> The "send signal when any mapper dies" proposal would do that. The other process
> could catch the signal and do something with it.
>

That would be a new signal such as SIG_FUTEXDIED, would it?


--
Greetz, Antonio Vargas aka winden of network

http://wind.codepixel.com/
windNOenSPAMntw@gmail.com
thesameasabove@amigascne.org

Every day, every year
you have to work
you have to study
you have to scene.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751673AbWFQPzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbWFQPzl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 11:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751671AbWFQPzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 11:55:41 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:6565 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751672AbWFQPzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 11:55:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=JAIRg4hVyOoMFMBxAhNeYLqi1nKutzeUrcIrqCc5PbY9jmNO6A8hOdwK/Dt/W0G450QyagLrEcam7tJ+wn1wOAcRQ90en7B4NO7woOuoyzE63o336hCuz0Iidtn2lxtDVkTGDUTgo6dM/epkUdsPt4EmdA41DPUnNEr4yGfSNU4=
Message-ID: <661de9470606170855rb47ed28hd75f4bfff8218bb3@mail.gmail.com>
Date: Sat, 17 Jun 2006 21:25:39 +0530
From: "Balbir Singh" <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: [RFC] CPU controllers?
Cc: vatsa@in.ibm.com, "Sam Vilain" <sam@vilain.net>,
       "Kirill Korotaev" <dev@openvz.org>, "Mike Galbraith" <efault@gmx.de>,
       "Ingo Molnar" <mingo@elte.hu>,
       "Peter Williams" <pwil3058@bigpond.net.au>,
       "Andrew Morton" <akpm@osdl.org>, sekharan@us.ibm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <4493C1D1.4020801@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060615134632.GA22033@in.ibm.com> <4493C1D1.4020801@yahoo.com.au>
X-Google-Sender-Auth: 437fb0e6b58d000a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> Srivatsa Vaddagiri wrote:
> > Hello,
> >       There have been several proposals so far on this subject and no
> > consensus seems to have been reached on what an acceptable CPU controller
> > for Linux needs to provide. I am hoping this mail will trigger some
> > discussions in that regard. In particular I am keen to know what the
> > various maintainers think about this subject.
> >
> > The various approaches proposed so far are:
> >
> >       - CPU rate-cap (limit CPU execution rate per-task)
> >               http://lkml.org/lkml/2006/5/26/7
> >
> >       - f-series CKRM controller (CPU usage guarantee for a task-group)
> >               http://lkml.org/lkml/2006/4/27/399
> >
> >       - e-series CKRM controller (CPU usage guarantee/limit for a task-group)
> >               http://prdownloads.sourceforge.net/ckrm/cpu.ckrm-e18.v10.patch.gz?download
> >
> >       - OpenVZ controller (CPU usage guarantee/hard-limit for a task-group)
> >               http://openvz.org/
> >
> >       - vserver controller (CPU usage guarantee(?)/limit for a task-group)
> >               http://linux-vserver.org/
> >
> > (I apologize if I have missed any other significant proposal for Linux)
> >
> > Their salient features and limitations/drawbacks, as I could gather, are
> > summarized later below. To note is each controller varies in degree of
> > complexity and addresses its own set of requirements.
> >
> > In going forward for an acceptable controller in mainline it would help, IMHO,
> > if we put together the set of requirements which the Linux CPU controller
> > should support. Some questions that arise in this regard are:
> >
> >       - Do we need mechanisms to control CPU usage of tasks, further to what
> >         already exists (like nice)?  IMO yes.
>
> Can we get back to the question of need? And from there, work out what
> features are wanted.
>
> IMHO, having containers try to virtualise all resources (memory, pagecache,
> slab cache, CPU, disk/network IO...) seems insane: we may just as well use
> virtualisation.
>
> So, from my POV, I would like to be convinced of the need for this first.
> I would really love to be able to keep core kernel simple and fast even if
> it means edge cases might need to use a slightly different solution.
>
> --
> SUSE Labs, Novell Inc.

The simplest example that comes to my mind to explain the need is
through quality of service. Consider a single system running two
instances of an application (lets say a web portal or a database
sever). If one of the instances is production and the other is
development, and if the development instance is being stress tested -
how do I provide reliable quality of service to the users of the
production instance?

I am sure other people will probably have better examples.

Warm Regards,

Balbir
Linux Technology Center
IBM, ISL

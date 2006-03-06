Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751726AbWCFP63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbWCFP63 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 10:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbWCFP63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 10:58:29 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:10859 "EHLO xsmtp1.ethz.ch")
	by vger.kernel.org with ESMTP id S1751726AbWCFP63 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 10:58:29 -0500
Message-ID: <440C5C1F.1070405@debian.org>
Date: Mon, 06 Mar 2006 16:58:23 +0100
From: "Giacomo A. Catenazzi" <cate@debian.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Sam Ravnborg <sam@ravnborg.org>, "Paul D. Smith" <psmith@gnu.org>,
       bug-make@gnu.org, LKML <linux-kernel@vger.kernel.org>,
       kbuild-devel@lists.sourceforge.net, Art Haas <ahaas@airmail.net>
Subject: Re: [kbuild-devel] Re: kbuild: Problem with latest GNU make rc
References: <17413.49617.923704.35763@lemming.engeast.baynetworks.com>	 <20060304214026.GB1539@mars.ravnborg.org>	 <17419.25684.389269.70457@lemming.engeast.baynetworks.com>	 <20060305231954.GA25710@mars.ravnborg.org>	 <440C4472.8000509@debian.org> <9a8748490603060748x6fbe715eq4c4a55a040cc6238@mail.gmail.com>
In-Reply-To: <9a8748490603060748x6fbe715eq4c4a55a040cc6238@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Mar 2006 15:58:23.0588 (UTC) FILETIME=[CC287240:01C64136]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On 3/6/06, Giacomo A. Catenazzi <cate@debian.org> wrote:
>> Sam Ravnborg wrote:
>>>>   sr> Suggestion:
>>>>   sr> We are now warned about an incompatibility in kbuild and we will
>>>>   sr> fix this asap. But that you postpone this particular behaviour
>>>>   sr> change until next make release. Maybe you add in this change as
>>>>   sr> the first thing after the stable relase so all bleeding edge make
>>>>   sr> users see it and can report issues.
>>>>
>>>> I am willing to postpone this change.  However, I can't say how much of
>>>> a window this delay will give you: I can say that it's extremely
>>>> unlikely that it will be another 3 years before GNU make 3.82 comes out.
>>> One year would be good. The fixed kernel build will be available in an
>>> official kernel in maybe two or three months form now. With current pace
>>> we will have maybe 3 more kernel relase until this hits us. And only on
>>> bleeding edge machines.
>> I don't think is a big issue. The short-cut "compile only the necessary
>> files" is used mainly by developers.
>> Anyway the kernel will remain correct. Maybe for old kernel it take more
>> time to build the kernel, but correct.
>>
>> BTW Debian building tools (IIRC) clean the sources before every kernel
>> building process, and in 2.4 (and previous) it was high recommended to
>> clean and recompile all kernel before any changes, so no big issue in
>> these cases.
>> I don't know other "normal use", but I think it is not a big issue if
>> people will need a complete build in the rare (IMHO) case that they
>> want to recompile kernel (with small patches or changes in configuration).
>>
> 
> Rebuilding the kernel tens (or hundreds) of times may be rare for most
> ordinary users, but it's quite common for kernel developers.
> Rebuilding the entire kernel every time you make a small change is a
> big problem and cost a lot of people a lot of time - and the people
> who will bear the cost are the ones who have to build many kernels.
> IMHO this is a big problem.

I think we misunderstand.
Developers will use recent kernel. So a patched kernel that work
also with newer make.
Only "normal user" will eventually use old kernel, thus the build
infrastructure will not work correctly (aka it will rebuild build
the whole kernel everytime) if they use a "future" make.

ciao
	cate

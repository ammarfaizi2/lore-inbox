Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752768AbWKBJ1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768AbWKBJ1n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 04:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752769AbWKBJ1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 04:27:42 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:6078 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752768AbWKBJ1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 04:27:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gOiSfcO+d2Rko0KCDzVrn1dyTmwmV1orkAs/Fra46BARw6ix/VdugRDjWNrSfUV+jb82T37o91MQVSmFQ1t3c0qMvylP0dNNmjSEiokiP0zmKwckbe4LhQu9JsNQJHnRez1G48ruZuuEN4tbfKgPFtr0Yo1nraJPhStNmlBsk8Q=
Message-ID: <6278d2220611020127j62f94ccat5a158059feab37cb@mail.gmail.com>
Date: Thu, 2 Nov 2006 09:27:40 +0000
From: "Daniel J Blueman" <daniel.blueman@gmail.com>
To: zhfeng.osprey@gmail.com
Subject: Re: How to optimize system time for such case?
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <b3c691930611020116n6ee14112lff7632be72e7df71@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6278d2220611020110m34d09673yee73edd6c0c86ff@mail.gmail.com>
	 <b3c691930611020116n6ee14112lff7632be72e7df71@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/06, miles <zhfeng.osprey@gmail.com> wrote:
> On 11/2/06, Daniel J Blueman <daniel.blueman@gmail.com> wrote:
> > FENG ZHOU wrote:
> > > Hello, all
> > > I am optimizing a compiler and I believe there is a bug in such
> > > compile. Currently, I have a test case, which is a scientific
> > > application, has a lot of system time. This is weird, because this
> > > case does not have many system calls. Meanwhile, compiled at another
> > > option, I found all the "system time" are gone! So, I assume there is
> > > some problem in the first one (though both binary produce correct
> > > result). I used some performance tuning tool and found the hottest
> > > address for CPU privilege level change event is: 0xa000000100001a70.
> > > This address is not in code or data segment. Now, I am kinda stuck
> > > here. My question is: how to find what this address is? Or find out
> > > what is the cause of the "system time"? Thanks in advance.
> > >
> > > PS: the platform is Itanium 2.
> > > -Feng
> >
> > First question is what kernel, second is how much memory?
> >
> > I recently had this experience (high system time) with some vendor
> > kernels with a system with 16GB of memory and 4-8GB processes. The VM
> > was trying to reclaim pages like crazy, but failing.
>
> The system is a debian3.1 with 2.6.8 #1 SMP kernel. The total memory is 4GB.
> Total number of processes is about 100. It is a SPEC CPU program.

I'd say it's worth a shot with a more modern kernel. There are
probably related bugs in that kernel. The one I had (related, but not
directly) problems with was 2.6.9 + vendor patches.
-- 
Daniel J Blueman

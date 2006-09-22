Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWIVMbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWIVMbP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 08:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbWIVMbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 08:31:15 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:47674 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932367AbWIVMbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 08:31:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oOTdi1961twN27mc2X8ldv/Ryume5EzvjcRUk1QNESbI4jjdKPTdC0zNnFFUkiyjcx2PCeLKNjozvM3Wm4sEC/yRJUJWzAfn3qLWB8M/h4IxP22JKIud6bCFkKwqEdckT1yDYmdQ6b55iM14TAsUBqVl4cIDUcRPXbIbhX2A2LU=
Message-ID: <69304d110609220531q70402d6dp31c28225e3b6e2a9@mail.gmail.com>
Date: Fri, 22 Sep 2006 14:31:13 +0200
From: "Antonio Vargas" <windenntw@gmail.com>
To: "Ludovic Drolez" <ludovic.drolez@linbox.com>
Subject: Re: [PATCH] sched.c: Be a bit more conservative in SMP
Cc: "Vincent Pelletier" <vincent.plr@wanadoo.fr>, linux-kernel@vger.kernel.org
In-Reply-To: <45138FAC.30700@linbox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200609031541.39984.subdino2004@yahoo.fr>
	 <69304d110609191050w777a5c48ibe84bc0e3ce65df3@mail.gmail.com>
	 <4510F0FD.4060602@linbox.com>
	 <200609212036.24856.vincent.plr@wanadoo.fr>
	 <45138FAC.30700@linbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/06, Ludovic Drolez <ludovic.drolez@linbox.com> wrote:
> Vincent Pelletier wrote:
> > Maybe I was completely wrong with my assumption that one running process
> > always has an impact of 1, which would have make the scheduler underestimate
> > the load on one cpu and put too many processes on it, without moving them
> > afterward.
>
> Yes, maybe that's the problem, since in my bench, one process takes only 40% of
> the CPU.
>
> Cheers,
>
> --
> Ludovic DROLEZ                              Linbox / Free&ALter Soft
> www.linbox.com www.linbox.org                 tel: +33 3 87 50 87 90
> 152 rue de Grigy - Technopole Metz 2000                   57070 METZ
> -

Provided you have enough memory, the somewhat better way to test this
is to turn off swap, copy the sources to a tmpfs directory and compile
there. Then any disks accesses would be only related to reloading code
pages from the compiler / daemons /shared libs, which having even more
ram would solve so that it's all compute bound. I guess even 1.5Gb of
ram is plenty for all this, and not so much costly nowdays for a
kernel hacker ;)


-- 
Greetz, Antonio Vargas aka winden of network

http://network.amigascne.org/
windNOenSPAMntw@gmail.com
thesameasabove@amigascne.org

Every day, every year
you have to work
you have to study
you have to scene.

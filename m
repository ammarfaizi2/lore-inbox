Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264729AbUEEX47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264729AbUEEX47 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 19:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264728AbUEEX47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 19:56:59 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:25063 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264724AbUEEX4z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 19:56:55 -0400
Date: Wed, 5 May 2004 17:00:15 -0700
From: Chandra Seetharaman <sekharan@us.ibm.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [ckrm-tech] Re: [RFC] Revised CKRM release
Message-ID: <20040506000015.GA26925@chandralinux.beaverton.ibm.com>
References: <4090BBF1.6080801@watson.ibm.com> <20040504173529.GE11346@logos.cnet> <409832D2.2020507@watson.ibm.com> <20040505184838.GC1350@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040505184838.GC1350@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2004 at 03:48:38PM -0300, Marcelo Tosatti wrote:
> 
> > >It sounds to me the classification engine can be moved to userspace? 
> > >
> > >Such "classification" sounds a better suited to be done there.
> > 
> > I suppose it could. However, one of our design objectives was to 
> > support multi-threaded server apps where each thread (task) changes 
> > its class fairly rapidly (say every time it starts doing work on 
> > behalf of a more/less important transaction). Doing a transition to 
> > userspace and back may be too costly for such a scenario.
> 
> But who sets the priority of the tasks is userspace anyway, isnt? AFAICS its

I didn't understand what do you mean by this (in this context)..
can you elaborate ?

> userspace who knows which transaction is more/less important. 

That is true, but the classfication event has to be notified to the
user space from kernel, wight ? Shailabh is refering that overhead
here.

> 
> > There might also be some concerns with keeping the reclassify 
> > operation atomic wrt deletion of the target class...but we haven't 
> > thought this through for userspace classification.
> 
> How often is a reclassify operation done?

events like fork, exec, setuid/setgid etc., also when the application
tag is explicitly changed(which could happen as many times as the
application wants).

> 
> > >Note: I haven't read the code yet.
> > >
> > 
> > Why just read when you can test as well :-) We just released a testing 
> > tarball at http://ckrm.sf.net.. any inputs, bugs will be most welcome !
> > 
> > Looking forward to more inputs,
> 
> Yeah, I'm just nitpicking from the outside and haven't contributed 
> to anything, so...
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by Sleepycat Software
> Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
> deliver higher performing products faster, at low TCO.
> http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
> _______________________________________________
> ckrm-tech mailing list
> https://lists.sourceforge.net/lists/listinfo/ckrm-tech
> 

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------

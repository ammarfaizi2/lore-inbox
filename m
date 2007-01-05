Return-Path: <linux-kernel-owner+w=401wt.eu-S1750725AbXAEV2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbXAEV2x (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 16:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbXAEV2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 16:28:53 -0500
Received: from wx-out-0506.google.com ([66.249.82.238]:30582 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbXAEV2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 16:28:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=otC72rPiE8S0wCZ9ls/ayU2pemItk6zDuEqLFQGE33eKVvMdIVbI3Qcr4PHwFNgkLcHFnupRMK0CFEX4F5VDOxROFcPMn4h6mBzZazYsbbeCzHZVf7/NX0J8iOnKkJJzYBgc262876eYqNjeGGrEgt6e7Xiw2Svzre9tBXSAB40=
Message-ID: <5a4c581d0701051328i49fb13ffse15c41b6531dfd71@mail.gmail.com>
Date: Fri, 5 Jan 2007 22:28:52 +0100
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: gorcunov@gmail.com
Subject: Re: qconf: reproducible segfault
Cc: "kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <200701051022.59914.gorcunov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <459C1966.7040209@xs4all.nl>
	 <200701041242.31508.gorcunov@gmail.com>
	 <5a4c581d0701041316w83d1564rac875a1d4e0ef87a@mail.gmail.com>
	 <200701051022.59914.gorcunov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/07, Cyrill V. Gorcunov <gorcunov@gmail.com> wrote:
> On Friday 05 January 2007 00:16, you wrote:
> |  On 1/4/07, Cyrill V. Gorcunov <gorcunov@gmail.com> wrote:
> |  > Hi,
> |  > there is SIGSEGV happens in qconf.cc:995
> |  >
> |  >         str += print_filter(sym->name);
> |  >
> |  > but sym points to 0x1. To reproduce the error just do:
> |  >
> |  > 1) make xconfig (with Options->Show Debug Info unchecked)
> |  > 2) go to Networking->Networking Options->Network packet filtering framework (Netfilter)->
> |  >    Network packet filtering framework (Netfilter) and the line "<| .." must be selected
> |  >    then just turn on Options->Show Debug info menu and you'll get:
> |  >
> |  >         make[1]: *** [xconfig] Segmentation fault
> |  >         make: *** [xconfig] Error 2
> |
> |  Cyrill, Randy - I feel like an idiot but I can't really reproduce this :(
> |
> |  I'm trimming lkml from the CC list to upload and attach two screenshots
> |   where I enabled Show Debug Info at what I guess are the two possible
> |   interpretations of where the Select highlight should be - and neither
> |   cause a core dump for me.
> |
> |  What am I mistaking ?
> |
> |  Thanks, ciao,

> Hi Alessandro,
>
> see enveloped scrshot to keep in mind how the qconf is looking at moment we
> get SYGSEGV error - you just need to set Options->Show Debug and oops ;)
> I don't know may be QT dev version does handling such exceptions itself and if
> SYGSEVG happens it just ignore it... But the qconf really have the error :(.

That's ok, apparently FC6's qt-devel-3.3.7 libs are capable of
 handling the problem (I can bring qconf to the exact screen
 you showed, Options->Show Debug Info does _not_ crash).

And of course it's better to fix the problem in qconf.cc rather
 than letting qt libs handle it :)

Thanks,

--alessandro

 "but I thought that I should let you know
  the things that I don't always show
  might not be worth the time it took"

     (Steve Wynn, 'If My Life Was An Open Book')

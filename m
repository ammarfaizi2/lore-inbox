Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265988AbTIJXXO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 19:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265997AbTIJXXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 19:23:14 -0400
Received: from mta02-svc.ntlworld.com ([62.253.162.42]:43212 "EHLO
	mta02-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S265988AbTIJXXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 19:23:12 -0400
From: James Clark <jimwclark@ntlworld.com>
Reply-To: jimwclark@ntlworld.com
To: root@chaos.analogic.com, Timothy Miller <miller@techsource.com>
Subject: Re: Driver Model 2 Proposal - Linux Kernel Performance v Usability
Date: Thu, 11 Sep 2003 00:22:16 +0100
User-Agent: KMail/1.5
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
References: <1062637356.846.3471.camel@cube> <3F5F8E90.4020701@techsource.com> <Pine.LNX.4.53.0309101640550.18999@chaos>
In-Reply-To: <Pine.LNX.4.53.0309101640550.18999@chaos>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309110022.16193.jimwclark@ntlworld.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anyone ever done any work to quantify what the loss in performance might 
be with a binary interface? 

James

On Wednesday 10 Sep 2003 9:48 pm, Richard B. Johnson wrote:
> On Wed, 10 Sep 2003, Timothy Miller wrote:
> > I just have one quick question about all of this:
> >
> > People mention that driver interfaces don't change much in stable
> > releases, but if memory serves, symbol versioning information changes
> > with each minor release, requiring a recompile of modules.
> >
> > Would it be possible to have a driver module which can be dropped into,
> > say, 2.6.17 that can also be dropped into 2.6.18 as long as the
> > interface doesn't change?
>
> Short answer, YES. Anything that can be done is possible. The
> problem is that different kernel versions end up with different
> structure members, etc. So, you can't use code for 2.2.xxx in
> 2.4.xx because, amongst other things, the first element in
> 'struct file_operations' was added and the others moved up.
>
> Now, you can make a different module interface that maintains
> a compatibility level ABI. This has been discussed. Unfortunately,
> this adds code in the execution path. This extra code gets
> executed every time the module code is accessed. The result being
> that the module can't possibly operate as fast as it would if
> there were no such compatibility layer(s). It might be "good enough",
> but it is unlikely that the module contributors/maintainers would
> allow such an interface because the loss of performance is measurable
> and there has been no requirement to trade-off performance for
> anything (your and my convenience doesn't count, those are not
> technical issues).
>
>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
>             Note 96.31% of all statistics are fiction.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


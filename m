Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319362AbSIFUAP>; Fri, 6 Sep 2002 16:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319368AbSIFUAP>; Fri, 6 Sep 2002 16:00:15 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:36561 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319362AbSIFUAO>;
	Fri, 6 Sep 2002 16:00:14 -0400
To: "David S. Miller" <davem@redhat.com>
cc: Martin.Bligh@us.ibm.com, hadi@cyberus.ca, tcw@tempest.prismnet.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, niv@us.ibm.com
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000 
In-reply-to: Your message of Fri, 06 Sep 2002 12:49:36 PDT.
             <20020906.124936.34476547.davem@redhat.com> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15786.1031342622.1@us.ibm.com>
Date: Fri, 06 Sep 2002 13:03:42 -0700
Message-Id: <E17nPKV-00046g-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020906.124936.34476547.davem@redhat.com>, > : "David S. Miller" w
rites:
>    From: Gerrit Huizenga <gh@us.ibm.com>
>    Date: Fri, 06 Sep 2002 12:52:15 -0700
>    
>    So if apache were using a listen()/clone()/accept()/exec() combo rather than a
>    full listen()/fork()/exec() model it would see most of the same benefits?
> 
> Apache would need to do some more, such as do something about
> cpu affinity and do the non-blocking VFS tricks Tux does too.
> 
> To be honest, I'm not going to sit here all day long and explain how
> Tux works.  I'm not even too knowledgable about the precise details of
> it's implementation.  Besides, the code is freely available and not
> too complex, so you can go have a look for yourself :-)

Aw, and you are such a good tutor, too.  :-)  But thanks - my particular
goal isn't to fix apache since there is already a group of folks working
on that, but as we look at kernel traces, this should give us a good
idea if we are at the bottleneck of the apache architecture or if we
have other kernel bottlenecks.  At the moment, the latter seems to be
true, and I think we have some good data from Troy and Dave to validate
that.  I think we have already seen the affinity problem or at least
talked about it as that was somewhat visible and Apache 2.0 does seem
to have some solutions for helping with that.  And when the kernel does
the best it can with Apache's architecture, we have more data to convince
them to fix the architecture problems.

thanks again!

gerrit

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262502AbVHDSvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbVHDSvL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 14:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbVHDSvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 14:51:04 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:35639 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262632AbVHDStS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 14:49:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kak/IoEo4OnkfpFLsENed4g86L8WtNOnFAvxEtj2sz/9hr52t6MG1X8H/EOYHYGrtUhYfiVyOjEBRDKYKZNkJkP9Kt/IkZYtl5XvxwPqZaPfiNXfnl9VM4HM1Qjv+aMUBvfvNw+7kgq21mn/PCtNTbvNRbKCAeBJ5qvHgLfTpUs=
Message-ID: <29495f1d050804114949284cbf@mail.gmail.com>
Date: Thu, 4 Aug 2005 11:49:16 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: george@mvista.com
Subject: Re: [UPDATE PATCH] push rounding up of relative request to schedule_timeout()
Cc: Nishanth Aravamudan <nacc@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
In-Reply-To: <42F24AC4.5080103@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.61.0507231456000.3728@scrub.home>
	 <20050723191004.GB4345@us.ibm.com>
	 <Pine.LNX.4.61.0507232151150.3743@scrub.home>
	 <20050727222914.GB3291@us.ibm.com>
	 <Pine.LNX.4.61.0507310046590.3728@scrub.home>
	 <20050801193522.GA24909@us.ibm.com>
	 <Pine.LNX.4.61.0508031419000.3728@scrub.home>
	 <20050804005147.GC4255@us.ibm.com> <20050804051434.GA4520@us.ibm.com>
	 <42F24AC4.5080103@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/05, George Anzinger <george@mvista.com> wrote:
> Nishanth Aravamudan wrote:
> ~
> > Sorry, I forgot that sys_nanosleep() also always adds 1 to the request
> > (to account for this same issue, I believe, as POSIX demands no early
> > return from nanosleep() calls). There are some other locations where
> > similar
> >
> >       + (t.tv_sec || t.tv_nsec)
> 
> This is not the same as "always add 1".  We don't do it this way just to
> have fun with C.  If you change schedule_timeout() to add the 1,
> nanosleep() will need to do things differently to get the same behavior.
>   (And, YES users do pass in zero sleep times.)

Fair enough. Will need to think about this more.

Thanks,
Nish

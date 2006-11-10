Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946155AbWKJJXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946155AbWKJJXP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 04:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946153AbWKJJXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 04:23:15 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:55232 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1946148AbWKJJXN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 04:23:13 -0500
Subject: Re: [PATCH -mm 3/3][AIO] - AIO completion signal notification
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>, Zach Brown <zach.brown@oracle.com>,
       Dave Jones <davej@redhat.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <1163099886.29807.20.camel@dyn9047017100.beaverton.ibm.com>
References: <1163087717.3879.34.camel@frecb000686>
	 <1163087946.3879.43.camel@frecb000686>
	 <1163099886.29807.20.camel@dyn9047017100.beaverton.ibm.com>
Date: Fri, 10 Nov 2006 10:22:10 +0100
Message-Id: <1163150530.3879.61.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/11/2006 10:29:09,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/11/2006 10:29:16,
	Serialize complete at 10/11/2006 10:29:16
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-09 at 11:18 -0800, Badari Pulavarty wrote:
> On Thu, 2006-11-09 at 16:59 +0100, Sébastien Dugué wrote:
> 
> > @@ -1549,8 +1657,7 @@ int fastcall io_submit_one(struct kioctx
> >  	ssize_t ret;
> >  
> >  	/* enforce forwards compatibility on users */
> > -	if (unlikely(iocb->aio_reserved1 || iocb->aio_reserved2 ||
> > -		     iocb->aio_reserved3)) {
> > +	if (unlikely(iocb->aio_reserved1)) {
> >  		pr_debug("EINVAL: io_submit: reserve field set\n");
> >  		return -EINVAL;
> 
> Is there a reason for not checking "aio_reserved3" ?
> You are still not using it. Right ?
> 

  Yep, forgot this one.

  Thanks,

  Sébastien.


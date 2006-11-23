Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757348AbWKWK1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757348AbWKWK1w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 05:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757349AbWKWK1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 05:27:52 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:53636 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1757348AbWKWK1v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 05:27:51 -0500
Date: Thu, 23 Nov 2006 11:27:41 +0100
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Zach Brown <zach.brown@oracle.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH -mm 3/4][AIO] - AIO completion signal notification
Message-ID: <20061123112741.44ef3be1@frecb000686>
In-Reply-To: <20061123021437.684d7c63.akpm@osdl.org>
References: <20061120151700.4a4f9407@frecb000686>
	<20061120152252.7e5a4229@frecb000686>
	<20061121170228.4412b572.akpm@osdl.org>
	<20061123092805.1408b0c6@frecb000686>
	<20061123004053.76114a75.akpm@osdl.org>
	<20061123104755.68561c66@frecb000686>
	<20061123021437.684d7c63.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/11/2006 11:34:42,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/11/2006 11:34:44,
	Serialize complete at 23/11/2006 11:34:44
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2006 02:14:37 -0800
Andrew Morton <akpm@osdl.org> wrote:

[snip]

> Look:
> 
> > +	notify->target = target;
> > +
> > +	if (notify->notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID)) {
> > +		/*
> > +		 * This reference will be dropped in really_put_req() when
> > +		 * we're done with the request.
> > +		 */
> > +		get_task_struct(target);
> 
> If that test fails, we've saved a pointer to the task_struct without having
> taken a refreence on it.
> 

  Aggreed, just wanted to make sure.

  Thanks,

  Sébastien.

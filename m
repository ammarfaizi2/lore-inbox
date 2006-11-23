Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753211AbWKWIYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211AbWKWIYe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 03:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754887AbWKWIYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 03:24:33 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:61391 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1753211AbWKWIYc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 03:24:32 -0500
Date: Thu, 23 Nov 2006 09:24:33 +0100
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Zach Brown <zach.brown@oracle.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@osdl.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH -mm 3/4][AIO] - AIO completion signal notification
Message-ID: <20061123092433.1d2b9c95@frecb000686>
In-Reply-To: <456424D7.7060204@oracle.com>
References: <20061120151700.4a4f9407@frecb000686>
	<20061120152252.7e5a4229@frecb000686>
	<4561C60B.5000106@oracle.com>
	<20061122104055.3d1c029a@frecb000686>
	<456424D7.7060204@oracle.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/11/2006 09:31:35,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/11/2006 09:31:36,
	Serialize complete at 23/11/2006 09:31:36
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2006 02:22:15 -0800
Zach Brown <zach.brown@oracle.com> wrote:

> >   OK, looking at this, there's something bothering me: io_submit_one() needs
> > a pointer to the user iocb in order to push back the iocb->ki_key to userspace,
> > as well as storing the user_iocb pointer into iocb->ki_obj.
> 
> Why can't it continue to do what it does today?  Both of those uses of
> the user_iocb pointer involve fixed-width fields and don't need compat help.

  Aah, right, thanks.

> 
> >   So I think that some of the logic in io_submit_one() must be moved up to
> > sys_io_submit(), including the aio_get_req() call.
> 
> I don't see why that would be needed.

  Not anymore, indeed.


  Thanks,

  Sébastien.

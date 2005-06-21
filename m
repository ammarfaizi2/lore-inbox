Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbVFUIbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbVFUIbG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 04:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbVFUIS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 04:18:28 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:21218 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261992AbVFUHh6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 03:37:58 -0400
Subject: Re: Pending AIO work/patches
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>,
       "linux-aio kvack.org" <linux-aio@kvack.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       wli@holomorphy.com, zab@zabbo.net, mason@suse.com, ysaito@hpl.hp.com
In-Reply-To: <20050620181007.GA4031@kvack.org>
References: <20050620120154.GA4810@in.ibm.com>
	 <20050620181007.GA4031@kvack.org>
Date: Tue, 21 Jun 2005 09:36:52 +0200
Message-Id: <1119339413.1400.31.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 21/06/2005 09:49:16,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 21/06/2005 09:49:17,
	Serialize complete at 21/06/2005 09:49:17
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-20 at 14:10 -0400, Benjamin LaHaise wrote:

> > (3) POSIX AIO support (Bull: Laurent/Sebastian or Oracle: Joel)
> > 	Status: Needs review and discussion ?
> 
> The latest version incorporates changes from the last round of feedback 
> (great work Sebastien!) and updates the library license, so people should 
> definately take a closer look.  This includes the necessary changes for 
> in-kernel signal support, as well as minimal conversion done on iocbs (the 
> layout matches the in-kernel iocb).
> 
> A quick reading shows that most of it looks quite good.  I have to stare 
> at the cancellation code a bit more closely, though.
> 

  As I understand it, cancellation needs support from the 
underlying filesystem in order to dequeue requests no yet
commited to disk.

  So far there is no support from the kernel aside from the USB gadget 
driver which registers its own 'iocb->ki_cancel' method for dequeuing
requests.

  Sébastien.

-- 
------------------------------------------------------

  Sébastien Dugué                BULL/FREC:B1-247
  phone: (+33) 476 29 77 70      Bullcom: 229-7770

  mailto:sebastien.dugue@bull.net

  Linux POSIX AIO: http://www.bullopensource.org/posix
  
------------------------------------------------------


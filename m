Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318977AbSICXWf>; Tue, 3 Sep 2002 19:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318980AbSICXWb>; Tue, 3 Sep 2002 19:22:31 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:17649
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318977AbSICXW3>; Tue, 3 Sep 2002 19:22:29 -0400
Subject: Re: aic7xxx sets CDR offline, how to reset?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Doug Ledford <dledford@redhat.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <20020903185036.G12201@redhat.com>
References: <alan@lxorguk.ukuu.org.uk>
	<200209032132.g83LWdD09043@localhost.localdomain> 
	<20020903185036.G12201@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 04 Sep 2002 00:28:47 +0100
Message-Id: <1031095727.21439.47.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-03 at 23:50, Doug Ledford wrote:
> Hmmm...I thought a big reason for adding REQ_BARRIER was to be able to 
> support more robust journaling with order requirement verification.  If 
> that's true, then REQ_BARRIER commands could become quite common on disks 
> using ext3.

I doubt it very much because the only way to implement barriers on IDE
is fantastically expensive. I'm dubious it makes sense for ext3 to use
barriers in that way. All it needs as I understand the rules is that an
I/O isnt reported as completed by the device driver before it is on the
medium or in a non volatile cache.



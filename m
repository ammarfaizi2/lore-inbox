Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318903AbSHEWas>; Mon, 5 Aug 2002 18:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318907AbSHEWas>; Mon, 5 Aug 2002 18:30:48 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:42229 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318903AbSHEWas>; Mon, 5 Aug 2002 18:30:48 -0400
Subject: Re: [PATCH] 2.5.30-dj1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Larson <plars@austin.ibm.com>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, davej@suse.de,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1028585494.19435.56.camel@plars.austin.ibm.com>
References: <Pine.NEB.4.44.0208051638340.27501-100000@mimas.fachschaften.tu-muenchen.de>
	 <1028579086.19435.31.camel@plars.austin.ibm.com> 
	<20020805214835.GP32427@mea-ext.zmailer.org> 
	<1028585494.19435.56.camel@plars.austin.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 06 Aug 2002 00:53:07 +0100
Message-Id: <1028591587.18156.127.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-05 at 23:11, Paul Larson wrote:

> cleaner way of doing it.  The problem is that this driver won't build if
> CONFIG_BROKEN_SCSI_ERROR_HANDLING isn't defined because in hosts.h we
> have this in the Scsi_Host_Template struct:
> #ifdef CONFIG_BROKEN_SCSI_ERROR_HANDLING
>          int (* abort)(Scsi_Cmnd *);
>          int (* reset)(Scsi_Cmnd *, unsigned int);
> #endif

We dont want it to build until its fixed

Take a look at http://www.andante.org/scsi_eh.html


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131270AbRCHEqh>; Wed, 7 Mar 2001 23:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131273AbRCHEq2>; Wed, 7 Mar 2001 23:46:28 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:7946 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S131270AbRCHEqS>; Wed, 7 Mar 2001 23:46:18 -0500
Message-Id: <200103080445.f284jsO36939@aslan.scsiguy.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Wakko Warner <wakko@animx.eu.org>
cc: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: 2.4.3-pre2 aic7xxx crash on alpha 
In-Reply-To: Your message of "Wed, 07 Mar 2001 21:09:43 EST."
             <20010307210943.A1330@animx.eu.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 07 Mar 2001 21:45:54 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>(scsi1:A:0:0): data overrun detected in Data-out phase.  Tag == 0x36.
>(scsi1:A:0:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.

As I mentioned to you the last time you brought up this problem, I
don't believe that this is caused by the aic7xxx driver, but the
aic7xxx driver may be the first to notice the corruption.  Somehow
the system is generating disk requests with a zero length buffer
provided to the controller.  That is the cause of the data-overruns.
Perhaps there is a problem with the dma mapping operations on your
particular type of Alpha?

--
Justin


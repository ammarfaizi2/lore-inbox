Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVFBK57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVFBK57 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 06:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVFBK57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 06:57:59 -0400
Received: from miranda.se.axis.com ([193.13.178.8]:44988 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S261375AbVFBK54 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 06:57:56 -0400
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: "'Arjan van de Ven'" <arjan@infradead.org>,
       "Mikael Starvik" <mikael.starvik@axis.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Accessing monotonic clock from modules
Date: Thu, 2 Jun 2005 12:57:51 +0200
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C66801B7645D@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C66802FA37AC@exmail1.se.axis.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>how about making this a _GPL export?

Yes

>also... when are you going to get this module merged?

Do we really want modules for all kind of exotic hardware only used by one
company in the kernel tree? In this case we are the only user of this module
since we make the HW ourself and doesn't resell it. So it's my headache if
any API or similar is changed.

>And if we are going to make it an official interface, does it have to be
>called "do_posix_clock_monotonic_gettime" ?  Perhaps a more
>export-friendly name?

Sure. Any suggestions welcome. 

/Mikael

-----Original Message-----
From: Arjan van de Ven [mailto:arjan@infradead.org] 
Sent: Thursday, June 02, 2005 9:30 AM
To: Mikael Starvik
Cc: linux-kernel@vger.kernel.org
Subject: Re: Accessing monotonic clock from modules


On Thu, 2005-06-02 at 08:36 +0200, Mikael Starvik wrote:
> We would like to get the posix monotonic clock from a loadable module.
> Would a patch to make do_posix_clock_monotonic_gettime exported ok or
> should we do it in some other way?
> 
> /Mikael

also... when are you going to get this module merged?
(exporting things without the module going into kernel.org shouldn't be
done imo... it makes it harder to change internals and causes overhead
for all kernel users)


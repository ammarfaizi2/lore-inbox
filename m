Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWDMOdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWDMOdP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 10:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWDMOdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 10:33:14 -0400
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:2003 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751244AbWDMOdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 10:33:14 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: notifier chain problem? (was Re: 2.6.17-rc1 did break XFS)
Date: Fri, 14 Apr 2006 00:32:10 +1000
User-Agent: KMail/1.9.1
Cc: Herbert Poetzl <herbert@13thfloor.at>, Jes Sorensen <jes@sgi.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com, stern@rowland.harvard.edu, sekharan@us.ibm.com,
       akpm@osdl.org, David Chinner <dgc@sgi.com>
References: <20060413052145.GA31435@MAIL.13thfloor.at> <20060413135000.GB6663@MAIL.13thfloor.at> <Pine.LNX.4.61.0604131618350.17374@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0604131618350.17374@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604140032.12086.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 April 2006 00:21, Jan Engelhardt wrote:
> >> Looks strange, the faulting address is in the same region as the
> >> eip. I am not that strong on x86 layouts, so I am not sure whether
> >> 0x78xxxxxx is the kernel's mapping or it's module space. Almost looks
> >> like something else had registered a notifier and then gone away
> >> without unregistering it.
> >
> >sorry, the essential data I didn't provide here is
> >probably that I configured the 2G/2G split, which for
> >unknown reasons actually is a 2.125/1.875 split and
> >starts at 0x78000000 (instead of 0x80000000)
>
> That's how it is coded in arch/i386/Kconfig. It says 78 rather than 80.
> Maybe Con has an idea?

Follow this thread backwards from this point:
http://marc.theaimsgroup.com/?l=linux-kernel&m=113690295909937&w=2

-- 
-ck

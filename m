Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964940AbWDMOVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbWDMOVh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 10:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbWDMOVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 10:21:36 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:42186 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964940AbWDMOVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 10:21:36 -0400
Date: Thu, 13 Apr 2006 16:21:18 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Herbert Poetzl <herbert@13thfloor.at>
cc: Jes Sorensen <jes@sgi.com>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com, stern@rowland.harvard.edu, sekharan@us.ibm.com,
       akpm@osdl.org, David Chinner <dgc@sgi.com>
Subject: Re: notifier chain problem? (was Re: 2.6.17-rc1 did break XFS)
In-Reply-To: <20060413135000.GB6663@MAIL.13thfloor.at>
Message-ID: <Pine.LNX.4.61.0604131618350.17374@yvahk01.tjqt.qr>
References: <20060413052145.GA31435@MAIL.13thfloor.at>
 <20060413072325.GF2732@melbourne.sgi.com> <yq0k69tuauh.fsf@jaguar.mkp.net>
 <20060413135000.GB6663@MAIL.13thfloor.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 
>> Looks strange, the faulting address is in the same region as the
>> eip. I am not that strong on x86 layouts, so I am not sure whether
>> 0x78xxxxxx is the kernel's mapping or it's module space. Almost looks
>> like something else had registered a notifier and then gone away
>> without unregistering it.
>
>sorry, the essential data I didn't provide here is
>probably that I configured the 2G/2G split, which for
>unknown reasons actually is a 2.125/1.875 split and
>starts at 0x78000000 (instead of 0x80000000)

That's how it is coded in arch/i386/Kconfig. It says 78 rather than 80.
Maybe Con has an idea?


Jan Engelhardt
-- 

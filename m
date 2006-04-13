Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbWDMSiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWDMSiQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 14:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWDMSiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 14:38:16 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:32418 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932324AbWDMSiP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 14:38:15 -0400
Subject: Re: notifier chain problem? (was Re: 2.6.17-rc1 did break XFS)
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Jes Sorensen <jes@sgi.com>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com, Alan Stern <stern@rowland.harvard.edu>,
       akpm@osdl.org, David Chinner <dgc@sgi.com>
In-Reply-To: <20060413175342.GF6663@MAIL.13thfloor.at>
References: <20060413052145.GA31435@MAIL.13thfloor.at>
	 <20060413072325.GF2732@melbourne.sgi.com> <yq0k69tuauh.fsf@jaguar.mkp.net>
	 <20060413135000.GB6663@MAIL.13thfloor.at>
	 <Pine.LNX.4.61.0604131618350.17374@yvahk01.tjqt.qr>
	 <20060413175342.GF6663@MAIL.13thfloor.at>
Content-Type: text/plain
Organization: IBM
Date: Thu, 13 Apr 2006 11:38:11 -0700
Message-Id: <1144953491.4762.77.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-13 at 19:53 +0200, Herbert Poetzl wrote:
> On Thu, Apr 13, 2006 at 04:21:18PM +0200, Jan Engelhardt wrote:
> > >> 
> > >> Looks strange, the faulting address is in the same region as the
> > >> eip. I am not that strong on x86 layouts, so I am not sure whether
> > >> 0x78xxxxxx is the kernel's mapping or it's module space. Almost looks
> > >> like something else had registered a notifier and then gone away
> > >> without unregistering it.
> > >
> > >sorry, the essential data I didn't provide here is
> > >probably that I configured the 2G/2G split, which for
> > >unknown reasons actually is a 2.125/1.875 split and
> > >starts at 0x78000000 (instead of 0x80000000)
> > 
> > That's how it is coded in arch/i386/Kconfig. It says 78 rather than 80.
> > Maybe Con has an idea?
> 
> here is the same oops with 3/1 split and the bootup log
> 

Hi Herbert,

Looks to be the same stack as earlier, Is there any modules compiled in
that were removed before you tried to mount the XFS filesystem ?

Can you send me the .config file.

chandra

<snip>

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------



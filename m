Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbWBZRvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbWBZRvy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 12:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWBZRvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 12:51:54 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:8463 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751237AbWBZRvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 12:51:53 -0500
Date: Sun, 26 Feb 2006 18:51:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Steve French <smfrench@austin.rr.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: cifs hang patch idea - reduce sendtimeo on socket
Message-ID: <20060226175152.GK3674@stusta.de>
References: <43F3FA4E.2050608@austin.rr.com> <20060216205623.GA8784@stusta.de> <1140644100.9942.15.camel@kleikamp.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140644100.9942.15.camel@kleikamp.austin.ibm.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 03:35:00PM -0600, Dave Kleikamp wrote:
> On Thu, 2006-02-16 at 21:56 +0100, Adrian Bunk wrote:
> > 
> > I'm a bit lost now, but I hope this information helps you in finding 
> > what is going wrong?
> 
> Steve and I think we have figured this out.  In some cases, CIFSSMBRead
> was returning a recently freed buffer.
>...

Thanks a lot!

In my testing, this patch applied against 2.6.14-rc4 fixed all problems 
I observed.

> David Kleikamp

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


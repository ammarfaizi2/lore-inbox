Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291787AbSBNQrQ>; Thu, 14 Feb 2002 11:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291781AbSBNQq7>; Thu, 14 Feb 2002 11:46:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39952 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291790AbSBNQqR>;
	Thu, 14 Feb 2002 11:46:17 -0500
Message-ID: <3C6BE9D5.23D596A9@mandrakesoft.com>
Date: Thu, 14 Feb 2002 11:46:13 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: torvalds@transmeta.com, davidm@hpl.hp.com,
        "David S. Miller" <davem@redhat.com>, anton@samba.org,
        linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [PATCH] move task_struct allocation to arch
In-Reply-To: <12086.1013704379@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> > Is this the first in a multi-step patch series, or something like that?
> 
> What makes you ask that?

Because your patch just flat out duplicates code line for line into two
arches.


> > You just duplicated code in a generic location and pasted it into the
> > arch.  Where's the gain in that?  I do see the gain in letting the arch
> > allocate the task struct, but surely your patch should provide a generic
> > mechanism for an arch to call by default, instead of duplicating code??
> 
> Hmmm... Is it worth going through all fun of creating another CONFIG_xxxx
> option to govern the inclusion of such code?

I am wondering where you want to go with this, short term and long
term.  Is the implementation of this on other arches gonna look the same
-- just line for line copy of code?  With maybe ia64 as the lone
exception?

	Jeff


-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com

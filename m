Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318383AbSHUQmM>; Wed, 21 Aug 2002 12:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318389AbSHUQmM>; Wed, 21 Aug 2002 12:42:12 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:29930 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S318383AbSHUQmM>; Wed, 21 Aug 2002 12:42:12 -0400
Message-ID: <3D63C3B1.328A872F@nortelnetworks.com>
Date: Wed, 21 Aug 2002 12:45:37 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: "Feldman, Scott" <scott.feldman@intel.com>,
       "'Troy Wilson'" <tcw@tempest.prismnet.com>,
       Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
       tcw@prismnet.com
Subject: Re: mdelay causes BUG, please use udelay
References: <288F9BF66CD9D5118DF400508B68C4460283E4AF@orsmsx113.jf.intel.com> <2544596606.1029920638@[10.10.2.3]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" wrote:

> Whilst this sort of delay in interrupt context is undoubtedly bad
> any way we do it, I'd question the context a little more before we
> make a decision. This is called from e1000_reset_hw - are we likely
> to ever actually call this except under initialisation?

I currently work on an embedded device and if we detect given network connection isn't working at
all our first response is to switch to a working connection, then we reload the device driver for
the non-working one.  Since we may be doing other things at the same time, having this stall the
machine for extended periods of time is definately not a good thing.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

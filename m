Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261849AbSIXX1A>; Tue, 24 Sep 2002 19:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261850AbSIXX1A>; Tue, 24 Sep 2002 19:27:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261849AbSIXX07>;
	Tue, 24 Sep 2002 19:26:59 -0400
Message-ID: <3D90F5D3.4070504@pobox.com>
Date: Tue, 24 Sep 2002 19:31:31 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brad Hards <bhards@bigpond.net.au>
CC: Tim Hockin <thockin@sun.com>, Chris Friesen <cfriesen@nortelnetworks.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       "ipslinux (Keith Mitchell)" <ipslinux@us.ibm.com>,
       Linus Torvalds <torvalds@home.transmeta.com>,
       Hien Nguyen <hien@us.ibm.com>, James Keniston <kenistoj@us.ibm.com>,
       Mike Sullivan <sullivam@us.ibm.com>
Subject: Re: alternate event logging proposal
References: <20020924073051.363D92C1A7@lists.samba.org> <3D90C4FE.3070909@pobox.com> <3D90D0FB.1070805@sun.com> <200209250832.35068.bhards@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Hards wrote:
> I liked the /sbin/hotplug arrangement (aka call_usermode_helper). In fact, my 
> plan was to add the call_usermode_helper call to the netif_carrier_[on,off] 
> functions. Unfortuantely, I've been to too many of Rusty's talks, and know 
> that calling a function that is only safe in user context is unlikely to be a 
> good idea in netif_carrier_[on,off], which are more than likely running in 
> interrupt context.


You really want something where a userspace app can sleep on an fd, to 
be awakened when link changes (or some other interesting event occurs)

	Jeff




Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292730AbSDIPq0>; Tue, 9 Apr 2002 11:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293203AbSDIPqZ>; Tue, 9 Apr 2002 11:46:25 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:1702 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S292730AbSDIPqZ>; Tue, 9 Apr 2002 11:46:25 -0400
Date: Tue, 9 Apr 2002 17:31:27 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Rob Radez <rob@osinvestor.com>
Cc: Corey Minyard <minyard@acm.org>, <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Further WatchDog Updates
In-Reply-To: <Pine.LNX.4.33.0204091057540.17511-100000@pita.lan>
Message-ID: <Pine.LNX.4.44.0204091722250.7771-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Apr 2002, Rob Radez wrote:

> Oops, yea, I forgot return values.  I'll fix that up.  I got rid of
> sc1200wdt_status because it returns bit 1, which is defined as WDIOF_OVERHEAT
> I suppose it would be possible to return WDIOF_KEEPALIVEPING instead.
> So something like if(ret & 0x01) return WDIOF_KEEPALIVEPING;?

Yes, that should be fine. But don't forget its inactive high ;)

so its...

return !(ret & 0x01) ? WDIOF_KEEPALIVEPING : 0;

Thanks,
	Zwane

-- 
http://function.linuxpower.ca
		


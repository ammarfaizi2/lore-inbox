Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273620AbRIYVNO>; Tue, 25 Sep 2001 17:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273806AbRIYVNE>; Tue, 25 Sep 2001 17:13:04 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:49123 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S273620AbRIYVM7>;
	Tue, 25 Sep 2001 17:12:59 -0400
Message-ID: <3BB0F4C8.124B6576@candelatech.com>
Date: Tue, 25 Sep 2001 14:19:04 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies Inc
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: Ethernet Error Correction
In-Reply-To: <Pine.LNX.3.95.1010925164155.11921A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Tue, 25 Sep 2001, Karel Kulhavy wrote:
> 
> > What about implementing an Ethernet error correction in Linux kernel?
> >
> 
> Ethernet uses hardware error detection. Only good packets get through.
> Therefore there is nothing that a driver in the kernel could do to
> recover an otherwise errored packet because the packet doesn't exist.
> 

That's probably the default of most chipsets, but I wonder if you could
tell it to send the busted packets up the stack anyway.  Then, the driver
could make the decision in software whether or not to correct/foward, or
discard the packet...  I assume that in order to detect a CRC error,
the NIC already has the packet in it's buffers somewhere...

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear

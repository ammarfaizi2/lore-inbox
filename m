Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284470AbRLJWEC>; Mon, 10 Dec 2001 17:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284506AbRLJWDx>; Mon, 10 Dec 2001 17:03:53 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:27635 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S284470AbRLJWDk>; Mon, 10 Dec 2001 17:03:40 -0500
Date: Mon, 10 Dec 2001 13:46:26 -0800
From: Chris Wright <chris@wirex.com>
To: Christopher Friesen <cfriesen@nortelnetworks.com>
Cc: Ben Greear <greearb@candelatech.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: question on select: How big can the empty buffer space be before select returns ready-to-write?
Message-ID: <20011210134626.A3537@figure1.int.wirex.com>
Mail-Followup-To: Christopher Friesen <cfriesen@nortelnetworks.com>,
	Ben Greear <greearb@candelatech.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3C145359.3090401@candelatech.com> <20011209233349.C27109@figure1.int.wirex.com> <3C15077B.6AD2693E@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C15077B.6AD2693E@nortelnetworks.com>; from cfriesen@nortelnetworks.com on Mon, Dec 10, 2001 at 02:05:31PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christopher Friesen (cfriesen@nortelnetworks.com) wrote:
> Chris Wright wrote:
> > 
> > * Ben Greear (greearb@candelatech.com) wrote:
> > > For instance, it appears that select will return that a socket is
> > > writable when there is, say 8k of buffer space in it.  However, if
> > > I'm sending 32k UDP packets, this still causes me to drop packets
> > > due to a lack of resources...
> > 
> > udp has a fixed 8k max payload. did you try breaking up your packets?
> 
> Are you sure about that? UDP has a 16-bit field for the length.  Thus the
> standard technically allows for packet sizes (including header) of up to 2^16
> (roughly 65K) bytes.

no, you are absolutely right, it's 16 bits.  sorry for spewing
misinformation.

cheers,
-chris

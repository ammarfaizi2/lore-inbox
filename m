Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317302AbSFGPfC>; Fri, 7 Jun 2002 11:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317303AbSFGPfB>; Fri, 7 Jun 2002 11:35:01 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:24196 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S317302AbSFGPfA>; Fri, 7 Jun 2002 11:35:00 -0400
Message-ID: <3D00D28B.BAC57EC@nortelnetworks.com>
Date: Fri, 07 Jun 2002 11:34:35 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: RFC: per-socket statistics on received/dropped packets
In-Reply-To: <3CFFB9F8.54455B6E@nortelnetworks.com> <20020606.202108.52904668.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> Your idea is totally useless for non-datagram sockets.
> Only datagram sockets use the interfaces where you bump
> the counters.
> 
> I don't like the patch, nor the idea behind it, at all.

Thanks for the feedback.

I buy the point about it only making sense for datagram sockets in its current
form.  Thus it would maybe make more sense to use udp_ioctl() rather than in the
generic socket ioctl.

However, what do you have against the basic idea of a program knowing how many
packets have 
been dropped on its sockets?  I added the feature to try and figure out where
packets were being dropped in an app I am developing, and so far its been very
useful.

More generally, is there a generic place that I could tie into for the counter
increment that would work for all sockets?  While tcp would automatically handle
the dropped packets, it might be useful to know how many there were.

Thanks,

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285813AbRLJTFW>; Mon, 10 Dec 2001 14:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286153AbRLJTFC>; Mon, 10 Dec 2001 14:05:02 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:30096 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S285829AbRLJTDk>; Mon, 10 Dec 2001 14:03:40 -0500
Message-ID: <3C15077B.6AD2693E@nortelnetworks.com>
Date: Mon, 10 Dec 2001 14:05:31 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wright <chris@wirex.com>
Cc: Ben Greear <greearb@candelatech.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: question on select: How big can the empty buffer space be before 
         select returns ready-to-write?
In-Reply-To: <3C145359.3090401@candelatech.com> <20011209233349.C27109@figure1.int.wirex.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> 
> * Ben Greear (greearb@candelatech.com) wrote:
> > For instance, it appears that select will return that a socket is
> > writable when there is, say 8k of buffer space in it.  However, if
> > I'm sending 32k UDP packets, this still causes me to drop packets
> > due to a lack of resources...
> 
> udp has a fixed 8k max payload. did you try breaking up your packets?

Are you sure about that? UDP has a 16-bit field for the length.  Thus the
standard technically allows for packet sizes (including header) of up to 2^16
(roughly 65K) bytes.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

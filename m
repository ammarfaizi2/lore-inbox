Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263402AbTKJMgJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 07:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263434AbTKJMgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 07:36:09 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:25287 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S263402AbTKJMgF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 07:36:05 -0500
Message-ID: <3FAF8632.8020906@softhome.net>
Date: Mon, 10 Nov 2003 13:36:02 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: net/packet/af_packet.c:{1057,1073}: flags vs. msg->flags
References: <Qifs.Pr.1@gated-at.bofh.it>
In-Reply-To: <Qifs.Pr.1@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   RTFM (man recv) brought the response:

MSG_TRUNC
     Return the real length of the packet, even when  it  was  longer
     than the passed buffer. Only valid for packet sockets.

   So packet socket is special case here.

   Sorry for disturbing.

P.S. Wondering - is there any way to find a size of next queued 
datagram? SIOCINQ? cannot find its description - not listed in man 
ioctl_list - but implementation inside of ap_packet.c does exactly this.

Ihar 'Philips' Filipau wrote:
> Hi!
> 
>    [ I'm trying to cc: netdev - but they are not that welcome - and 
> require subscription. I'm way too lazy (and my mail box is not that 
> fast) to subscribe to send simple typo - if this is a case at all. ]
> 
>    [ kernel v2.6.0-test7 as found on lxr.linux.no, 2.4.{18,22} has the 
> same - but line numbers are different. ]
> 
>    On line 1057 we have: "msg->msg_flags|=MSG_TRUNC;" to indicate that 
> message was truncated.
> 
>    But on line 1073, where we make return status to user, we check 
> against user suplied flags, but NOT msg->msg_flags.
> 
>    It looks like obvious typo.
> 


-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  "... and for $64000 question, could you get yourself       |_|*|_|
    vaguely familiar with the notion of on-topic posting?"   |_|_|*|
                                 -- Al Viro @ LKML           |*|*|*|


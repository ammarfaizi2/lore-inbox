Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264276AbTF3Ns3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 09:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264099AbTF3Ns3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 09:48:29 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:37845 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S264030AbTF3Ns0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 09:48:26 -0400
Message-ID: <3F004302.4070907@nortelnetworks.com>
Date: Mon, 30 Jun 2003 10:02:42 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org
Subject: Re: [BUG]:   problem when shutting down ppp connection since 2.5.70
References: <3EFFA1EA.7090502@nortelnetworks.com> <16128.7306.58928.879567@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras wrote:

> Is this the user-mode pppoe or the in-kernel pppoe?  IOW, are you
> using the pppoe channel type, or do you have the usermode program that
> runs pppd behind a pty?

I believe its the Roaring Penguin usermode one.  I'm fairly sure PPPOE 
isn't enabled in the kernel.  I'm at work now, so it'll have to wait 
till this evening to make sure.

> And, do you have any TCP connections open over the link when you take
> it down?

On at least some of the occasions there should have been no connections 
open as the machine had just booted and the first thing I did after X 
came up was to shutdown adsl.

> What version of pppd is it?

Not sure--will check later.  Pretty sure its Mandrake 9 default.

> Has anyone been able to replicate this without using pppoe?  The type
> of channel shouldn't make any difference, but I just tried ppp over a
> pty and it worked fine (except that Deflate is broken, but that's
> another problem).

Note that I can only reliably reproduce it if the dsl connection is 
brought up at init time.  If I don't bring it up automatically at init 
but manually bring it up later, the problem doesn't seem to occur.

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com


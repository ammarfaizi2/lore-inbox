Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWF2PFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWF2PFm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 11:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWF2PFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 11:05:42 -0400
Received: from mail.tmr.com ([64.65.253.246]:25538 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S1750770AbWF2PFl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 11:05:41 -0400
Message-ID: <44A3E898.1020202@tmr.com>
Date: Thu, 29 Jun 2006 10:50:00 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4) Gecko/20060516 SeaMonkey/1.0.2
MIME-Version: 1.0
To: CaT <cat@zip.com.au>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.17.1: fails to fully get webpage
References: <20060629015915.GH2149@zip.com.au> <20060628.194627.74748190.davem@davemloft.net> <20060629030923.GI2149@zip.com.au> <20060628.204709.41634813.davem@davemloft.net> <20060629041827.GJ2149@zip.com.au>
In-Reply-To: <20060629041827.GJ2149@zip.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CaT wrote:
> On Wed, Jun 28, 2006 at 08:47:09PM -0700, David Miller wrote:
>> You can save yourself that hassle by informing the site admin
>> of the affected site that they have a firewall that misinterprets
>> the RFC standard window scaling field of the TCP headers.  These
>> devices assume it is zero because they don't remember the window
>> scale negotiated at the beginning of the TCP connection.
>>
>> Your TCP performance will suffer greatly if you disable window
>> scaling across the board.  It means that only a 64K window will
>> be usable by TCP, and you'll not be able to fill the pipe.
>>
>> Please don't use a screwdriver to pound in a nail :)
> 
> Indeed. The hassle I'm thinking of is the reverse situation (and please
> correct me if this does not apply). Say for example I run a web server.
> I have customers and they have customers (lets call them CCs :). Somewhere
> along the path between me and CCs there is such a misbehaving device.
> The CCs try to get to my customers website and fail (I assume). If my
> assumption is right, what's the probability of the CCs ever informing my
> customer that there is a problem? I think it's more likely they would
> just move on to another site offering the same thing, especially since
> they would mostlikely need to load the site in order to get the
> appropriate contact details.
> 
> Basically the mostlikely end-result is I don't know what there is a
> problem and my customer doesn't know that there is a problem but they're
> just not getting as many hits to their site that they otherwise would.
> 
> Ofcourse, this all depends if such a situation is possible. If it is
> possible would it affect dns and mail in a similar manner too?
> 
I'm glad David Miller clarified this, because I was about to send a 
"don't do that" followup ;-)

But your example is misleading, or at least doesn't reflect customers I 
know. While a few clients with broken network connections may be 
unhappy, disabling scaling will make your web server really, really, 
slow, and that will make everyone unhappy. Particularly if the web 
content is flash or 2MB jpegs, or other ill-chosen stuff. You don't want 
people to think you are running at dial-up speeds.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbTLLCtT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 21:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264464AbTLLCtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 21:49:19 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:56511 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S264461AbTLLCtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 21:49:17 -0500
Message-ID: <3FD92CA4.20606@nortelnetworks.com>
Date: Thu, 11 Dec 2003 21:49:08 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: David T Hollis <dhollis@davehollis.com>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: udev for dummies
References: <20031211221604.GA2939@werewolf.able.es> <1071183521.5900.36.camel@dhollis-lnx.kpmg.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David T Hollis wrote:
> On Thu, 2003-12-11 at 17:16, J.A. Magallon wrote:

>>What am I missing / misunderstanding ?

> You may be overthinking it a bit.  I just set up udev on my box and it's
> working quite well.  It's not really intending to completely replace
> /dev, rather it provides a dynamic device structure based on hotplugged
> devices.

Greg can speak to this better than I, but udev is most certainly 
intended to completely replace /dev.  The thing is that not everything 
exports the required information in /sys just yet.

If you start up udev and then run the script that comes with it that 
parses all the pre-existing /sys entries, it will build a pretty decent 
set of device nodes.  Eventually it is intended that this will be 
mounted at /dev, which could be an on-disk filesystem or else a 
tmpfs-based one.

Once all the information is in /sys, then static /dev will go away 
forever.  (Which is good, since device numbers will be random in 2.7.)

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com


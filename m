Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264192AbTEWU7H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 16:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264193AbTEWU7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 16:59:07 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:52619 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S264192AbTEWU7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 16:59:04 -0400
Message-ID: <3ECE9C6C.70103@myrealbox.com>
Date: Fri, 23 May 2003 15:10:52 -0700
From: walt <wa1ter@myrealbox.com>
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.4b) Gecko/20030517
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: karbas-lkml@frontier.tky.hut.fi
CC: linux-kernel@vger.kernel.org
Subject: Re: Tigon3 auto-negotiation and force media
References: <fa.jus6v70.biufpm@ifi.uio.no>
In-Reply-To: <fa.jus6v70.biufpm@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kari Kallioinen wrote:
> Hi,
> 
> I have a problem with broadcomm 5700 based card.
> It's autonegotiating a wrong media and I can't change the parameters of another
> end of link. So how I can force specified media technology with tg3-driver?
> Mii-tool doesn't seem to work and I didn't find any option for tg3-module.

I have the same chip on my motherboard and I have found that doing an
'ifconfig down' followed by 'ifconfig up' will make the chip work.
(You may need to restore the default route after doing the above.
Or, if you have an appropriate initscript in /etc/rc.d or /etc/init.d
you can just use it to restart the network -- same idea but less trouble.)

BTW, how do can you tell that the media choice is wrong?  'ifconfig' doesn't
give me that information.




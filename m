Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269027AbUHMIFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269027AbUHMIFJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 04:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269041AbUHMIFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 04:05:09 -0400
Received: from tentacle.s2s.msu.ru ([193.232.119.109]:56271 "EHLO
	tentacle.sectorb.msk.ru") by vger.kernel.org with ESMTP
	id S269027AbUHMIDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 04:03:36 -0400
Date: Fri, 13 Aug 2004 12:03:34 +0400
From: "Vladimir B. Savkin" <master@sectorb.msk.ru>
To: Nuno Silva <nuno.silva@vgertech.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.6.8-rc4-bk1 problem: unregister_netdevice: waiting for ppp0 to become free. Usage count = 1
Message-ID: <20040813080334.GA13337@tentacle.sectorb.msk.ru>
References: <411BC284.6080807@vgertech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <411BC284.6080807@vgertech.com>
X-Organization: Moscow State Univ., Dept. of Mechanics and Mathematics
X-Operating-System: Linux 2.6.8-rc3-barrier
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 08:18:28PM +0100, Nuno Silva wrote:
> Hi!
> 
> With 2.6.8-rc4-bk1 I get "Aug 12 17:33:10 puma kernel:
> unregister_netdevice: waiting for ppp0 to become free. Usage count = 1"
> in the logs after pppd exit.
> 
> Also, the box won't reboot and print that message forever in the
> console. sysrq-U && sysrq-R did it :-)
> 
> The last version I tried was 2.6.8-rc2-bk11 and, wrt this prob, is
> running fine. So, the problem is in that window and the changelog for
> rc4 mentions something about ppp:
> http://kernel.org/pub/linux/kernel/v2.6/testing/ChangeLog-2.6.8-rc4
> 
> If someone requires more information or tests feel free to ask!

I saw this too, with 2.6.7-rc3-mm1.
I have discovered that it happens because of idle TCP socket
holds a reference to a network device.
After killing associated process, device was freed immediately.

~
:wq
                                        With best regards, 
                                           Vladimir Savkin. 


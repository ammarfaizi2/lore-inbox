Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264042AbUDQU2x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 16:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264043AbUDQU2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 16:28:52 -0400
Received: from aun.it.uu.se ([130.238.12.36]:45745 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264042AbUDQU2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 16:28:51 -0400
Date: Sat, 17 Apr 2004 22:28:42 +0200 (MEST)
Message-Id: <200404172028.i3HKSgYP004574@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@muc.de, andihartmann@01019freenet.de
Subject: Re: SATA support merge in 2.4.27
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Apr 2004 13:36:11 +0200, Andi Kleen wrote:
>Andreas Hartmann <andihartmann@01019freenet.de> writes:
>
>> Marcelo Tosatti wrote:
>>> On Fri, Apr 16, 2004 at 10:51:02AM -0300, Marcelo Tosatti wrote:
>>> And again, unfortunately not everyone is running v2.6 on their production
>>> environment, yet.
>>
>> That's right! I certainly won't run it before 2.6.20 or even higher on
>> desktops. For example, 2.6 vanilla is much to slow (about 9%), even on
>> desktops - tested with compiling. It must be fixed.
>
>This most likely comes from the 1ms timer tick vs 10ms previously.  I
>doubt this will change in mainline, but you can change it yourself
>with an easy tweak. Just change the HZ parameter back to 100

I have a patch which adds CONFIG_HZ for the i386 and ppc architectures,
allowing you to choose HZ==1000, HZ==100, or HZ=512. I originally wrote
it because my oldest test box (a 486) loses lots of timer interrupts
during heavy disk I/O otherwise, but I also use it on less handicapped
boxes because I find HZ==1000 to be wasteful and of little value for me.

http://www.csd.uu.se/~mikpe/linux/patches/2.6/patch-config-hz-2.6.6-rc1

/Mikael

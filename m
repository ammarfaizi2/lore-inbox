Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbWFNN4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbWFNN4S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 09:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWFNN4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 09:56:18 -0400
Received: from server1.meinberg.de ([85.10.202.66]:47800 "EHLO
	paolo.meinberg.de") by vger.kernel.org with ESMTP id S964935AbWFNN4R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 09:56:17 -0400
Message-ID: <44901575.8090105@meinberg.de>
Date: Wed, 14 Jun 2006 15:56:05 +0200
From: Heiko Gerstung <heiko.gerstung@meinberg.de>
Organization: Meinberg Radio Clocks
User-Agent: Thunderbird 1.5.0.2 (X11/20060601)
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Backport of a 2.6.x USB driver to 2.4.32 - help needed
References: <mailman.1149588721.11795.linux-kernel2news@redhat.com> <20060609162634.b98fde7c.zaitcev@redhat.com>
In-Reply-To: <20060609162634.b98fde7c.zaitcev@redhat.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Pete:

Pete Zaitcev wrote:
> On Tue, 06 Jun 2006 11:48:36 +0200, Heiko Gerstung <heiko.gerstung@meinberg.de> wrote:
> 
>> [...] The maintainer of the driver
>> modified a few things for me in order to address this problem ("it
>> happens because get/set_registers() are called with no process
>> context"), but he was only able to modify the 2.6.x driver for me.
> 
>> I started to backport the modified version, but it seems that I ran into
>> dependency hell because I get the following two missing functions
>> reported when I try to compile the backported module:
>>
>> rtl8150.c: In Funktion »rtl8150_get_settings«:
>> rtl8150.c:790: Warnung: implicit declaration of function `in_atomic'
>> rtl8150.c: In Funktion »rtl8150_thread«:
>> rtl8150.c:857: Warnung: implicit declaration of function
>> `schedule_timeout_uninterruptible'
> 
> Tell the author to do it differently. Drivers have no business
> to call in_atomic(). So, he postpones some accesses until later.
> This is an easy way out, I did it myself in 2.4's usb-serial,
> but it's wrong. I don't see what his excuse is. Mine was that
> I didn't want to debug a freaking gazillion of usb-storage
> subdrivers.

His "excuse" is that he simply has not enough time to "do it right"(tm),
he just wanted to help me with a quick workaround.

> Who's the guy, anyway? Was it Petkan? I'm sure he'll listen
> to reason, I worked with him before.
Yes, it's Petko and I know that he is a good coder and just wanted to
help me out, although he was busy with projects he gets paid for.

> I'm going to keep an eye on rtl8150 and oppose in_atomic when
> it sneaks in.
Don't worry, I was not able to resolve the problems I got by working
around other problems. We will have to check if there is another
solution for our product as we have no chance to use a 2.4 kernel anymore.

Kind regards,
Heiko


> 
> -- Pete


-- 
------------------------------------------------------------------------

*MEINBERG Funkuhren GmbH & Co. KG*
Auf der Landwehr 22
D-31812 Bad Pyrmont, Germany
Tel.: ++49 (0)5281 9309-25
Fax: ++49 (0)5281 9309-30
eMail: heiko.gerstung@meinberg.de <mailto:heiko.gerstung@meinberg.de>
Internet: www.meinberg.de <http://www.meinberg.de/>

------------------------------------------------------------------------

Meinberg radio clocks: 25 years of accurate time worldwide


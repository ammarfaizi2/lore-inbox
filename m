Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262663AbVGHNyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262663AbVGHNyr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 09:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbVGHNyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 09:54:47 -0400
Received: from aun.it.uu.se ([130.238.12.36]:43906 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262663AbVGHNyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 09:54:46 -0400
Date: Fri, 8 Jul 2005 15:54:00 +0200 (MEST)
Message-Id: <200507081354.j68Ds02b020296@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ink@jurassic.park.msu.ru, teanropo@cc.jyu.fi
Subject: Re: [SOLVED] Re: 2.6.13-rc2 hangs at boot
Cc: gregkh@suse.de, jonsmirl@gmail.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jul 2005 12:38:28 +0300 (EEST), Tero Roponen wrote:
>On Fri, 8 Jul 2005, Ivan Kokshaysky wrote:
>
>> On Fri, Jul 08, 2005 at 10:57:56AM +0300, Tero Roponen wrote:
>> > Thanks! Vanilla 2.6.13-rc2 with below patch applied
>> > works perfectly!
>>
>> Thanks for testing. Though, bad news are that it's still unclear
>> why your machine doesn't like large cardbus windows and therefore
>> how to fix that correctly.
>>
>
>> May I ask you to do couple of another tests with following variations
>> of the latest patch (this will help to determine whether it's IO or
>> MEM ranges to blame)?
>> 1.
>> #define CARDBUS_IO_SIZE		(256)
>> #define CARDBUS_MEM_SIZE	(32*1024*1024)
>
>This works correctly.
>
>
>
>>
>> 2.
>> #define CARDBUS_IO_SIZE		(4096)
>> #define CARDBUS_MEM_SIZE	(4*1024*1024)
>
>This hangs at boot.

Same here: 2.6.13-rc2 vanilla and 2.6.13-rc2 + patch #2 above both hang,
but 2.6.13-rc2 + patch #1 boots fine.

/Mikael

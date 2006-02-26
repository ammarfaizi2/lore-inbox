Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWBZLfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWBZLfN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 06:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWBZLfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 06:35:13 -0500
Received: from ns.kam-telecom.ru ([86.109.192.26]:37519 "EHLO
	kt-sv-1.kam-telecom.ru") by vger.kernel.org with ESMTP
	id S1751323AbWBZLfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 06:35:11 -0500
X-Mailer: XFMail 1.5.4 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
In-Reply-To: <4400B562.6020203@argo.co.il>
Date: Sun, 26 Feb 2006 16:34:59 +0500 (YEKT)
From: Victor Porton <porton@ex-code.com>
To: Avi Kivity <avi@argo.co.il>
Subject: Re: New reliability technique
Cc: linux-kernel@vger.kernel.org, Jesper Juhl <jesper.juhl@gmail.com>
Message-Id: <E1FDKB1-0001GK-00@porton.narod.ru>
X-URL: http://porton.ex-code.com/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 25-Feb-2006 Avi Kivity wrote:
> Jesper Juhl wrote:
...
>>>On 2/25/06, Victor Porton <porton@ex-code.com> wrote:
>>>    
>>>
>>>>In idle cycles (or periodically in expense of some performance) Linux can
>>>>calculate MD5 or CRC sums of _unused_ (free) memory areas and compare these
>>>>sums with previously calculated sums.
>>>>
>>>>Additionally it can be done for allocated memory, if it will be write
>>>>protected before the first actual write. Moreover, all memory may be made
>>>>write-protected if it is not written e.g. more than a second. (When it
>>>>is written kernel would unlock it and allow to write, by a techniqie like
>>>>to how swap works.) If write-protected memory appears to be modified by
>>>>a check sum, this likewise indicates a bug.
>>>>
>>>>If a sum is inequal, it would notice a bug in kernel or in hardware.
>>>>
>>>>I suggest to add "Check free memory control sums" in config.

> No, they don't. They cover only a very small percentage of memory.
> 
> On the other hand, ECC memory and caches do this in hardware.

Isn't it better to double check (especially after such risky things as
e.g. software suspend)?

We need to check not only for damaged hardware, but also for
kernel/modules bugs. For this ECC and cache reliability is useless.

-- 
Victor Porton (porton@ex-code.com) - http://porton.ex-code.com

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268759AbUHZLOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268759AbUHZLOx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 07:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268729AbUHZLMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 07:12:01 -0400
Received: from picard.azzurra.org ([194.246.127.200]:22022 "HELO
	picard.azzurra.org") by vger.kernel.org with SMTP id S268730AbUHZLJY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 07:09:24 -0400
Message-ID: <32951.151.37.215.244.1093518560.squirrel@webmail.azzurra.org>
Date: Thu, 26 Aug 2004 13:09:20 +0200 (CEST)
Subject: include/linux/crc-ccitt.h and userspace programs
From: city_hunter@azzurra.org
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings,
I encountered a problem this morning while compiling a program which
includes /usr/include/net/ppp_defs.h

I know that userspace programs are highly discouraged from including
directly kernel headers, but /usr/include/net/ppp_defs.h is not supposed
to be one of them, right?
Problem is that net/ppp_defs.h includes linux/ppp_defs.h, which in turn
includes linux/crc-ccitt.h

This last header makes use of some types (u16,u8) that, if I am not wrong,
only exist when you're compiling something kernel-related (if __KERNEL__
is defined,asm/types.h will typedef u16 and the others).

So the program goes in error because u16 and u8 were never defined.

Who made the mistake here? :) (me?)

If crc-ccitt.h gets included in userspace program, then shouldn't it use 
__u16 and __u8? Can I safely replace u16 with __u16 and so on in
crc-ccitt.h to have everything compile ok?

Thanks in advance for your advices,
and please CC me as I'm not subscribed.

Regards,
Giacomo Lozito

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264175AbUESNsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264175AbUESNsp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 09:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264182AbUESNsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 09:48:45 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:59406 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S264175AbUESNso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 09:48:44 -0400
Message-ID: <40AB65B3.2070102@cs.wisc.edu>
Date: Wed, 19 May 2004 08:48:35 -0500
From: Alexander Mirgorodskiy <mirg@cs.wisc.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: apm standby on thinkpad
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

I ran into a problem with APM on a Thinkpad T41: the system cannot
properly resume after a standby. The backlight turns on, but the
screen remains blank. This happens on keypress (fn-f3) and
idle-time-induced standbys. However, resume after "apm -S" works just
fine.

I inserted some trace statements into the apm kernel driver and found
that it does not seem to receive standby and resume notifications from
BIOS if standby is initiated through fn-f3. At the same time, it does
receive the notification on a resume from "apm -S".

Any idea why that happens?

Thanks,
Alex

--

P.S: I see this on a RedHat 9 system with the 2.4.20 kernel. For a
bunch of reasons, I cannot upgrade to anything else in the short
term. (I did try 2.4.26, but it behaved even worse -- didn't wake up
at all, even if standby was entered with "apm -S")



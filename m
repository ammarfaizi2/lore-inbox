Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUC3ENa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 23:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbUC3ENa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 23:13:30 -0500
Received: from ns1.wanfear.com ([207.212.57.1]:49637 "EHLO ns1.wanfear.com")
	by vger.kernel.org with ESMTP id S262406AbUC3EN3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 23:13:29 -0500
Message-ID: <4068F3E7.9060005@candelatech.com>
Date: Mon, 29 Mar 2004 20:13:27 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: kernel thread scheduling question
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a kernel thread that I would like to have run at least
every 1-2 miliseconds.

I think I would be happy if there were a way to have the
process yield/schedule() at least once per ms with the
understanding that it would get to wake again 1-2ms later.
Is there a way to do such a thing without hacking up the
scheduler code?

I have tried 2.6.4 with pre-empt, and setting the thread priority
to -18, but I still see cases where the process is starved for 20+
milliseconds every 3-5 seconds or so.  Other than this single
process, there is not a big load on the system.

Any suggestions are welcome.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


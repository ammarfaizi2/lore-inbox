Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263742AbTEYUSa (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 25 May 2003 16:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbTEYUSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 16:18:30 -0400
Received: from holomorphy.com ([66.224.33.161]:22687 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263742AbTEYUS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 16:18:27 -0400
Date: Sun, 25 May 2003 13:31:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Mika Penttil? <mika.penttila@kolumbus.fi>,
   Zwane Mwaikambo <zwane@linuxpower.ca>, Ingo Molnar <mingo@elte.hu>,
   Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH][2.5] Possible race in wait_task_zombie and finish_task_switch
Message-ID: <20030525203115.GB8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	Mika Penttil? <mika.penttila@kolumbus.fi>,
	Zwane Mwaikambo <zwane@linuxpower.ca>, Ingo Molnar <mingo@elte.hu>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0305251226170.25774-100000@localhost.localdomain> <Pine.LNX.4.50.0305250625050.19617-100000@montezuma.mastecende.com> <3ED0A248.10308@kolumbus.fi> <3ED0A7CF.9040803@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ED0A7CF.9040803@colorfullife.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 25, 2003 at 01:23:59PM +0200, Manfred Spraul wrote:
> Hmm. What is schedule.c:746? There is no BUG in that area in the bk tree.
> Zwane, is it easy to reproduce the crash? I could write a patch that 
> adds 4 refcounters, then we could find out in which area we must look.

There's a check in -mm that reads an otherwise unused chunk of the task_t
and checks to see if it's slab poison.


-- wli

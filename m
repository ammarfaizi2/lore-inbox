Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129773AbQLYDJz>; Sun, 24 Dec 2000 22:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130010AbQLYDJf>; Sun, 24 Dec 2000 22:09:35 -0500
Received: from monza.monza.org ([209.102.105.34]:12051 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S129773AbQLYDJa>;
	Sun, 24 Dec 2000 22:09:30 -0500
Date: Sun, 24 Dec 2000 18:38:56 -0800
From: Tim Wright <timw@splhi.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Tim Wright <timw@splhi.com>, Kai Henningsen <kaih@khms.westfalen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: About Celeron processor memory barrier problem
Message-ID: <20001224183856.A2133@scutter.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Tim Wright <timw@splhi.com>,
	Kai Henningsen <kaih@khms.westfalen.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20001224125023.A1900@scutter.internal.splhi.com> <Pine.LNX.4.10.10012241410240.4404-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012241410240.4404-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Dec 24, 2000 at 02:25:54PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 24, 2000 at 02:25:54PM -0800, Linus Torvalds wrote:
> 
> Indeed. Some of the issues end up just becoming compiler flags, which
> means that anything that uses C is "tainted" by the processor choice. And
> happily there isn't all that much non-C in the kernel any more.
> 
> One thing we _could_ potentially do is to simplify the CPU selection a
> bit, and make it a two-stage process. Basically have a
> 
> 	bool "Optimize for current CPU" CONFIG_CPU_CURRENT
> 
> which most people who just want to get the best kernel would use. Less
> confusion that way.
> 
> 		Linus

Makes sense. Are you thinking along the lines of parsing /proc/cpuinfo to work
out what is there, or did you have something else in mind ?

Regards,

Tim

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

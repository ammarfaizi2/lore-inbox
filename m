Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129477AbRAEBAM>; Thu, 4 Jan 2001 20:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131167AbRAEBAC>; Thu, 4 Jan 2001 20:00:02 -0500
Received: from hermes.mixx.net ([212.84.196.2]:6151 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129518AbRAEA7q>;
	Thu, 4 Jan 2001 19:59:46 -0500
Message-ID: <3A551BD7.E8708B6F@innominate.de>
Date: Fri, 05 Jan 2001 01:56:55 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-prerelease i586)
X-Accept-Language: en
MIME-Version: 1.0
To: ludovic fernandez <ludovic.fernandez@sun.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.0-prerelease: preemptive kernel.
In-Reply-To: <Pine.LNX.4.05.10101041157540.4778-100000@cosmic.nrg.org> <3A54DEBF.794C2E6A@sun.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ludovic fernandez wrote:
> Right now I will be interested to run some benchmarks (latency but
> also performance) to see how the system is disturbed by beeing
> preemptable. I'm little bit lost on this and I don't know where to start.
> Do you have any pointers on benchmark suites I could run ?
> Also, maybe it's a off topic subject now....

No!  Not off topic.  And I hope you don't throw away that simple patch,
it will always be useful for doing reality checks on the performance of
the fancy system, and who knows, maybe it's useful in its own right.

The current fashion is to use dbench:

  ftp://samba.org/pub/tridge/dbench

I think this is good for your patch because it's inherently parallel. 
Interesting numbers of tasks are, e.g., 1, 2, 10, 50.   Of course dbench
is not the last word in benchmarks but it's been pretty useful so far. 
You probably want something entirely cpu-bound too.  How about dbench
with ramfs?

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

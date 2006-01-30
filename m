Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWA3IjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWA3IjH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 03:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWA3IjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 03:39:07 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:485 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751258AbWA3IjF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 03:39:05 -0500
Message-ID: <43DDD1DA.6060507@aitel.hist.no>
Date: Mon, 30 Jan 2006 09:44:10 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Howard Chu <hyc@symas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Lee Revell <rlrevell@joe-job.com>,
       Christopher Friesen <cfriesen@nortel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hancockr@shaw.ca
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
References: <20060124225919.GC12566@suse.de>  <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de>  <20060125121125.GH5465@suse.de> <43D78262.2050809@symas.com>  <43D7BA0F.5010907@nortel.com>  <43D7C2F0.5020108@symas.com> <1138223212.3087.16.camel@mindpipe> <43D7F863.3080207@symas.com> <43D88E55.7010506@yahoo.com.au> <43D8DB90.7070601@symas.com> <43D8E298.3020402@yahoo.com.au> <43D8E96B.3070606@symas.com> <43D8EFF7.3070203@yahoo.com.au> <43D8FC76.2050906@symas.com> <Pine.LNX.4.61.0601261231460.9298@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0601261231460.9298@chaos.analogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:

>To fix the current problem, you can substitute usleep(0); It will
>give the CPU to somebody if it's computable, then give it back to
>you. It seems to work in every case that sched_yield() has
>mucked up (perhaps 20 to 30 here).
>  
>
Isn't that dangerous?  Someday, someone working on linux (or some
other unixish os) might come up with an usleep implementation where
usleep(0) just returns and becomes a no-op.  Which probably is ok
with the usleep spec - it did sleep for zero time . . .

Helge Hafting

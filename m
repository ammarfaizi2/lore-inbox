Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267266AbTAKRXQ>; Sat, 11 Jan 2003 12:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267289AbTAKRXQ>; Sat, 11 Jan 2003 12:23:16 -0500
Received: from packet.digeo.com ([12.110.80.53]:58011 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267266AbTAKRXQ> convert rfc822-to-8bit;
	Sat, 11 Jan 2003 12:23:16 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andrew Morton <akpm@digeo.com>
To: Arador <diegocg@teleline.es>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.56 strange behaviour
Date: Sat, 11 Jan 2003 09:32:10 -0800
User-Agent: KMail/1.4.3
References: <20030111174757.7fb73379.diegocg@teleline.es>
In-Reply-To: <20030111174757.7fb73379.diegocg@teleline.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301110932.10550.akpm@digeo.com>
X-OriginalArrivalTime: 11 Jan 2003 17:31:56.0781 (UTC) FILETIME=[56D539D0:01C2B997]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat January 11 2003 08:47, Arador wrote:
>
> Hi, i've observed an "strange" thing in 2.5.56 (and 2.5.55 too)
>
> ...
>
> As you see, the cs rate goes from 2??? to 200000-300000.
> I wanted to know if it's the expected behaviour.
>

I've seen this too.  It's ext3, possibly related to the singular
sleep_on_buffer() call failing to sleep.

Anton Blanchard has a cute patch which changes the kernel profiler to profile
calls to schedule() instead of just instructions and I have ported that to
ia32.  But I haven't got around to actually using it yet.

We'll get there ;)

Thanks.




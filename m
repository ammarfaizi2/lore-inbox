Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270864AbTHGV0Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 17:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270880AbTHGV0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 17:26:24 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:25537
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S270864AbTHGV0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 17:26:19 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6: More about interactivity
Date: Fri, 8 Aug 2003 07:31:34 +1000
User-Agent: KMail/1.5.3
References: <1060280139.1406.17.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1060280139.1406.17.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308080731.34924.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Aug 2003 04:15, Felipe Alfaro Solana wrote:
> Just wanted to throw a few thoughts I have about the current scheduler
> and my experiences with it (well, with my specific workloads and
> applications on my little 700 Mhz PIII laptop).
>
> I feel that 2.6.0-test2-mm5 is not as smooth as 2.6.0-test2-mm2 (O10int)
> was. I am experiencing sound skips, but this time I'm not using XMMS,
> but Juk, a KDE player which uses the aRTS sound daemon, which in turn, I
> assume it uses the OSS API.
>
> With X reniced at +0, the system feels not as smooth as 2.6.0-test2-mm2,
> but at least there are no sound skips. However, to gain on smoothness, I
> have chosen to renice X to -20. Renicing X to -20 makes Juk skip like
> crazy simply by dragging a window over the screen. Also, with X at -20,
> opening a long Bookmarks Konqueror menu also causes sound skips (even
> with XMMS). By now, I'm sticking at +0, but I really miss those times
> when I was running O10int and the desktop was as smooth as silk.
>
> Now, let's go on talking about plain 2.6.0-test2-bk6. I feel it not as
> good as Con's scheduler and, when starting a CPU hoggers, I can feel how
> the system lags (starves) considerably for a few seconds. For example,
> when launching an absurd while loop (while true; do a=2; done), X stops
> responding for nearly 1 second, then becomes responsive but laggy for
> another one, and then starts acting normally.
>
> When O10int was released, I knew and felt the scheduler was working
> great for me (well, it worked great with my workload and applications),
> but now I'm starting to get afraid that, for me, it's getting again up
> to a point like in the past when I was forced to continuously tweak
> every kernel knob to try to make it smoother and make it fit my
> particular needs.
>
> Is there any pending work on the scheduler that I don't know of, or are
> we getting past a point-of-no-return, where the scheduler will be left
> as it is right now? I'm saying this as it is a long time since I haven't
> heard any notice about new developments on the subject from either Con
> or Ingo...

It's ok I'm not dead. It is true I'm having to rethink some of my work to 
bring some aspects of the interactive performance back up to O10 with Ingo's 
changes. The changes since his patch have gone in have addressed other issues 
but I'm trying to get it back to O10 standard in your issues. Just keep 
testing when I throw patches at you and remember I have an unrelated day job 
and family so the weekend is kinda good for development.

Con


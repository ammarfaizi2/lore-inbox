Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272332AbTHECFg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 22:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272361AbTHECFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 22:05:36 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:25242
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272332AbTHECFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 22:05:30 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Charlie Baylis <cb-lkml@fish.zetnet.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O12.2int for interactivity
Date: Tue, 5 Aug 2003 12:10:42 +1000
User-Agent: KMail/1.5.3
References: <20030804195058.GA8267@cray.fish.zetnet.co.uk>
In-Reply-To: <20030804195058.GA8267@cray.fish.zetnet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308051210.42779.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003 05:50, Charlie Baylis wrote:
> > I tried them aggressively; irman2 and thud don't hurt here. The idle
> > detection limits both of them from gaining too much sleep_avg while
> > waiting around and they dont get better dynamic priority than 17.
>
> Sounds like you've taken the teeth out of the thud program :) The original
> aim was to demonstrate what happens when a maximally interactive task
> suddenly becomes a CPU hog - similar to a web browser starting to render
> and causing intense X activity in the process. Stopping thud getting
> maximum priority is addressing the symptom, not the cause. (That's not to
> say the idle detection is a bad idea - but it's not the complete answer)

It was a side effect that it helped this particular issue. The idle detection 
was based around helping real world scenarios and it just happened to help.

> the idea is to do a little bit of work so that the idle detection doesn't
> kick in and thud can reach the max interactive bonus. (I haven't tried your
> patch yet to see if this change achieves this)

Good call; I was quite aware this is the most effective way to create a fork 
bomb with my patch, but it's effect while being noticably worse than the 
original thud is still not disastrous. Yes I do appreciate variations on the 
theme can be made worse again; I'm doing some testing and experimenting there 
to see how best to tackle it.

Con


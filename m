Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030192AbWHOKng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbWHOKng (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 06:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbWHOKng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 06:43:36 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:63371
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1030192AbWHOKnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 06:43:35 -0400
Date: Tue, 15 Aug 2006 03:43:17 -0700
To: Robert Crocombe <rcrocomb@gmail.com>
Cc: Esben Nielsen <nielsen.esben@gmail.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [Patch] restore the RCU callback to defer put_task_struct() Re: Problems with 2.6.17-rt8
Message-ID: <20060815104317.GA2138@gnuppy.monkey.org>
References: <20060808025615.GA20364@gnuppy.monkey.org> <20060808030524.GA20530@gnuppy.monkey.org> <Pine.LNX.4.64.0608090050500.23474@frodo.shire> <20060810021835.GB12769@gnuppy.monkey.org> <20060811010646.GA24434@gnuppy.monkey.org> <e6babb600608110800g379ed2c3gd0dbed706d50622c@mail.gmail.com> <20060811211857.GA32185@gnuppy.monkey.org> <20060811221054.GA32459@gnuppy.monkey.org> <e6babb600608141056j4410380fr15348430738c91d8@mail.gmail.com> <20060814234423.GA31230@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060814234423.GA31230@gnuppy.monkey.org>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 04:44:23PM -0700, Bill Huey wrote:
> On Mon, Aug 14, 2006 at 10:56:39AM -0700, Robert Crocombe wrote:
> > And yeah, it is a RAID config.  But for extra bonus points, I found a
> > spare SCSI disk and installed Fedora Core 5 and did a 'yum upgrade' to
> > whatever was current as of today.  So it's a single disk config now.
> > Problem still occurs with 't2' patched kernel.
> > 
> > config and dmesg attached, kaboom-like stuff appended.
> 
> It looks like a screw interaction between the latency tracer and the mutex
> code that creates such a wacked out looking stack trace. Unfortunately,
> I've been unsuccessful at reproducing it, so I'm going to focus on a partial
> clean up so that the rtmutex is a bit more friendly to the latency tracer.
> 
> This is kind of a pain.

I'm high, the latency tracer is fine. I'm going to look at the mutex code more.

bill


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270464AbRH1Iq7>; Tue, 28 Aug 2001 04:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270467AbRH1Iqu>; Tue, 28 Aug 2001 04:46:50 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:4871 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S270464AbRH1Iqk>; Tue, 28 Aug 2001 04:46:40 -0400
Message-ID: <3B8B5A73.258A3A0E@namesys.com>
Date: Tue, 28 Aug 2001 12:46:43 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Mike Galbraith <mikeg@wen-online.de>
CC: Dieter N|tzel <Dieter.Nuetzel@hamburg.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        ReiserFS List <reiserfs-list@namesys.com>,
        "Gryaznova E." <grev@namesys.botik.ru>
Subject: Re: [reiserfs-list] Re: [resent PATCH] Re: very slow parallel read 
 performance
In-Reply-To: <Pine.LNX.4.33.0108280645130.607-100000@mikeg.weiden.de>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> 
> On Tue, 28 Aug 2001, Dieter N|tzel wrote:
> 
> > * readahead do not show dramatic differences
> > * killall -STOP kupdated DO
> >
> > Yes, I know it is dangerous to stop kupdated but my disk show heavy thrashing
> > (seeks like mad) since 2.4.7ac4. killall -STOP kupdated make it smooth and
> > fast, again.
> 
> Interesting.
> 
> A while back, I twiddled the flush logic in buffer.c a little and made
> kupdated only handle light flushing.. stay out of the way when bdflush
> is running.  This and some dynamic adjustment of bdflush flushsize and
> not stopping flushing right _at_ (biggie) the trigger level produced
> very interesting improvements.  (very marked reduction in system time
> for heavy IO jobs, and large improvement in file rewrite throughput)
> 
>         -Mike


Can you send us the patch, and Elena will run some tests on it?

Hans

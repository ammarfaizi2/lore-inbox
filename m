Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280305AbRKEHrw>; Mon, 5 Nov 2001 02:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280306AbRKEHrm>; Mon, 5 Nov 2001 02:47:42 -0500
Received: from lilly.ping.de ([62.72.90.2]:18707 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id <S280305AbRKEHrh>;
	Mon, 5 Nov 2001 02:47:37 -0500
Date: 5 Nov 2001 08:46:33 +0100
Message-ID: <20011105084633.A32243@planetzork.spacenet>
From: jogi@planetzork.ping.de
To: "Linus Torvalds" <torvalds@transmeta.com>
Cc: "Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.14-pre8..
In-Reply-To: <Pine.LNX.4.33.0111031740330.9962-100000@penguin.transmeta.com> <20011104192725.A847@planetzork.spacenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20011104192725.A847@planetzork.spacenet>; from jogi on Sun, Nov 04, 2001 at 07:27:25PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 07:27:25PM +0100, jogi wrote:
> On Sat, Nov 03, 2001 at 05:44:18PM -0800, Linus Torvalds wrote:
> > 
> > Ok, this is hopefully the last 2.4.14 pre-kernel, and per popular demand I
> > hope to avoid any major changes between "last pre" and final. So give it a
> > whirl, and don't whine if the final doesn't act in a way you like it to.
> > 
> > Special thanks to Andrea - we spent too much time tracking down a subtle
> > sigsegv problem, but we got it in the end.
> > 
> > Also, I was able to reproduce the total lack of interactivity that the
> > google people complained about, and while I didn't run the google tests
> > themselves, at least the load I had is fixed.
> > 
> > But most of the changes are actually trying to catch up with some of the
> > emails that I ignored while working on the VM issues. I hope the VM is
> > good to go, along with a real 2.4.14.
> 
> The results for 2.4.14-pre8 of my kernel compile tests are following:
> 
>                     j25       j50       j75      j100                                     
>                                                                                           
> 2.4.13-pre5aa1:   5:02.63   5:09.18   5:26.27   5:34.36                                   
> 2.4.13-pre5aa1:   4:58.80   5:12.30   5:26.23   5:32.14                                   
> 2.4.13-pre5aa1:   4:57.66   5:11.29   5:45.90   6:03.53                                   
> 2.4.13-pre5aa1:   4:58.39   5:13.10   5:29.32   5:44.49                                   
> 2.4.13-pre5aa1:   4:57.93   5:09.76   5:24.76   5:26.79                                   
>                                                                                           
> 2.4.14-pre6:      4:58.88   5:16.68   5:45.93   7:16.56                                   
> 2.4.14-pre6:      4:55.72   5:34.65   5:57.94   6:50.58                                   
> 2.4.14-pre6:      4:59.46   5:16.88   6:25.83   6:51.43                                   
> 2.4.14-pre6:      4:56.38   5:18.88   6:15.97   6:31.72                                   
> 2.4.14-pre6:      4:55.79   5:17.47   6:00.23   6:44.85                                   
>                                                                                           
> 2.4.14-pre7:      4:56.39   5:22.84   6:09.05   9:56.59                                   
> 2.4.14-pre7:      4:56.55   5:25.15   7:01.37   7:03.74                                   
> 2.4.14-pre7:      4:59.44   5:15.10   6:06.78   12:51.39*                                 
> 2.4.14-pre7:      4:58.07   5:30.55   6:15.37      *                                      
> 2.4.14-pre7:      4:58.17   5:26.80   6:41.44      *
> 
> 2.4.14-pre8:      4:57.14   5:10.72   5:54.42   6:37.39
> 2.4.14-pre8:      4:59.57   5:11.63   6:34.97   11:23.77
> 2.4.14-pre8:      4:58.18   5:16.67   6:07.88   6:32.38
> 2.4.14-pre8:      4:56.23   5:16.57   6:15.01   7:02.45
> 2.4.14-pre8:      4:58.53   5:19.98   5:39.09   12:08.69
> 
> Is there anything else I can measure during the kernel compiles?
> Are the numbers for >= -pre6 slower because of measures taken to
> increase the "interactivity" / responsivness of the kernel?
> 
> The part that looks most suspicious to me is that the results
> for make -j100 vary so much ...

So here are the results of the complete run for the SetPage...
patch of Linus:

2.4.14-pre8vmscan2:    5:01.64   5:12.03   6:08.62   6:19.32
2.4.14-pre8vmscan2:    4:56.70   5:15.50   6:17.80   6:50.60
2.4.14-pre8vmscan2:    4:56.86   5:14.12   6:02.09   6:16.18
2.4.14-pre8vmscan2:    4:59.43   5:18.02   5:58.50   6:16.87
2.4.14-pre8vmscan2:    4:56.75   5:17.18   5:52.73   6:15.04

Regards,

   Jogi

-- 

Well, yeah ... I suppose there's no point in getting greedy, is there?

    << Calvin & Hobbes >>

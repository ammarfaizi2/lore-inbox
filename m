Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286670AbSAMRrQ>; Sun, 13 Jan 2002 12:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286758AbSAMRrG>; Sun, 13 Jan 2002 12:47:06 -0500
Received: from lilly.ping.de ([62.72.90.2]:39689 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id <S286670AbSAMRq5>;
	Sun, 13 Jan 2002 12:46:57 -0500
Date: 13 Jan 2002 18:42:49 +0100
Message-ID: <20020113184249.A15955@planetzork.spacenet>
From: jogi@planetzork.ping.de
To: "Andrew Morton" <akpm@zip.com.au>
Cc: "Ed Sweetman" <ed.sweetman@wmich.edu>, "Andrea Arcangeli" <andrea@suse.de>,
        yodaiken@fsmlabs.com, "Robert Love" <rml@tech9.net>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>, nigel@nrg.org,
        "Rob Landley" <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy> <20020112121315.B1482@inspiron.school.suse.de> <20020112160714.A10847@planetzork.spacenet> <20020112095209.A5735@hq.fsmlabs.com> <20020112180016.T1482@inspiron.school.suse.de> <005301c19b9b$6acc61e0$0501a8c0@psuedogod> <3C409B2D.DB95D659@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3C409B2D.DB95D659@zip.com.au>; from akpm@zip.com.au on Sat, Jan 12, 2002 at 12:23:09PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2002 at 12:23:09PM -0800, Andrew Morton wrote:
> Ed Sweetman wrote:
> > 
> > If you want to test the preempt kernel you're going to need something that
> > can find the mean latancy or "time to action" for a particular program or
> > all programs being run at the time and then run multiple programs that you
> > would find on various peoples' systems.   That is the "feel" people talk
> > about when they praise the preempt patch.
> 
> Right.  And that is precisely why I created the "mini-ll" patch.  To
> give the improved "feel" in a way which is acceptable for merging into
> the 2.4 kernel.
> 
> And guess what?   Nobody has tested the damn thing, so it's going
> nowhere.

Ok, as promised, here are the results:

        13-pre5aa1      18-pre2aa2      18-pre3         18-pre3s        18-pre3sp       18-pre3minill  
j100:   6:59.79  78%    7:07.62  76%        *           6:39.55  81%    6:24.79  83%        *
j100:   7:03.39  77%    8:10.04  66%        *           8:07.13  66%    6:21.23  83%        *
j100:   6:40.40  81%    7:43.15  70%        *           6:37.46  81%    6:03.68  87%        *
j100:   7:45.12  70%    7:11.59  75%        *           7:14.46  74%    6:06.98  87%        *
j100:   6:56.71  79%    7:36.12  71%        *           6:26.59  83%    6:11.30  86%        *
		                                                                                          
j75:    6:22.33  85%    6:42.50  81%    6:48.83  80%    6:01.61  89%    5:42.66  93%    7:07.56  77%
j75:    6:41.47  81%    7:19.79  74%    6:49.43  79%    5:59.82  89%    6:00.83  88%    7:17.15  74%
j75:    6:10.32  88%    6:44.98  80%    7:01.01  77%    6:02.99  88%    5:48.00  91%    6:47.48  80%
j75:    6:28.55  84%    6:44.21  80%    9:33.78  57%    6:19.83  85%    5:49.07  91%    6:34.02  83%
j75:    6:17.15  86%    6:46.58  80%    7:24.52  73%    6:23.50  84%    5:58.06  88%    7:01.39  77%

Regards,

   Jogi

-- 

Well, yeah ... I suppose there's no point in getting greedy, is there?

    << Calvin & Hobbes >>

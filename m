Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288757AbSANEtG>; Sun, 13 Jan 2002 23:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288760AbSANEsx>; Sun, 13 Jan 2002 23:48:53 -0500
Received: from dsl081-053-223.sfo1.dsl.speakeasy.net ([64.81.53.223]:27264
	"EHLO starship.berlin") by vger.kernel.org with ESMTP
	id <S288757AbSANEsj>; Sun, 13 Jan 2002 23:48:39 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: jogi@planetzork.ping.de, "Andrea Arcangeli" <andrea@suse.de>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Sun, 13 Jan 2002 23:55:11 +0100
X-Mailer: KMail [version 1.3.2]
Cc: "Robert Love" <rml@tech9.net>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
        nigel@nrg.org, "Rob Landley" <landley@trommello.org>,
        "Andrew Morton" <akpm@zip.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <20020112121315.B1482@inspiron.school.suse.de> <20020112160714.A10847@planetzork.spacenet>
In-Reply-To: <20020112160714.A10847@planetzork.spacenet>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16PtX0-0000VA-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 12, 2002 04:07 pm, jogi@planetzork.ping.de wrote:
> Hello Andrea,
> 
> I did my usual compile testings (untar kernel archive, apply patches,
> make -j<value> ...
> 
> Here are some results (Wall time + Percent cpu) for each of the consecutive five runs:
> 
>         13-pre5aa1      18-pre2aa2      18-pre3         18-pre3s        18-pre3sp
> j100:   6:59.79  78%    7:07.62  76%        *           6:39.55  81%    6:24.79  83%
> j100:   7:03.39  77%    8:10.04  66%        *           8:07.13  66%    6:21.23  83%
> j100:   6:40.40  81%    7:43.15  70%        *           6:37.46  81%    6:03.68  87%
> j100:   7:45.12  70%    7:11.59  75%        *           7:14.46  74%    6:06.98  87%
> j100:   6:56.71  79%    7:36.12  71%        *           6:26.59  83%    6:11.30  86%
> 
> j75:    6:22.33  85%    6:42.50  81%    6:48.83  80%    6:01.61  89%    5:42.66  93%
> j75:    6:41.47  81%    7:19.79  74%    6:49.43  79%    5:59.82  89%    6:00.83  88%
> j75:    6:10.32  88%    6:44.98  80%    7:01.01  77%    6:02.99  88%    5:48.00  91%
> j75:    6:28.55  84%    6:44.21  80%    9:33.78  57%    6:19.83  85%    5:49.07  91%
> j75:    6:17.15  86%    6:46.58  80%    7:24.52  73%    6:23.50  84%    5:58.06  88%
> 
> * build incomplete (OOM killer killed several cc1 ... )
> 
> So far 2.4.13-pre5aa1 had been the king of the block in compile times.
> But this has changed. Now the (by far) fastest kernel is 2.4.18-pre
> + Ingos scheduler patch (s) + preemptive patch (p). I did not test
> preemptive patch alone so far since I don't know if the one I have
> applies cleanly against -pre3 without Ingos patch. I used the
> following patches:
> 
> s: sched-O1-2.4.17-H6.patch
> p: preempt-kernel-rml-2.4.18-pre3-ingo-1.patch
> 
> I hope this info is useful to someone.

I'd like to add my 'me too' to those who have requested a re-run of this test, building
the *identical* kernel tree every time, starting from the same initial conditions.
Maybe that's what you did, but it's not clear from your post.

Thanks,

Daniel

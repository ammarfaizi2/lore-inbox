Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262889AbTDIH4s (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 03:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262893AbTDIH4s (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 03:56:48 -0400
Received: from adsl-216-103-111-100.dsl.snfc21.pacbell.net ([216.103.111.100]:39826
	"EHLO www.piet.net") by vger.kernel.org with ESMTP id S262889AbTDIH4p (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 03:56:45 -0400
Subject: Re: Linux kernel crash dumps (LKCD) and PowerPC ports.
From: Piet Delaney <piet@www.piet.net>
To: Arun Dharankar <ADharankar@ATTBI.Com>
Cc: piet <piet@www.piet.net>, "Matt D. Robinson" <yakker@alacritech.com>,
       linux-kernel@vger.kernel.org, Dave Anderson <anderson@redhat.com>
In-Reply-To: <200304082349.27844.ADharankar@ATTBI.Com>
References: <200304081647.32146.ADharankar@ATTBI.Com>
	<1049843693.10620.34.camel@lambda.alacritech.com> 
	<200304082349.27844.ADharankar@ATTBI.Com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 09 Apr 2003 01:08:22 -0700
Message-Id: <1049875702.22212.6634.camel@www.piet.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-04-08 at 20:49, Arun Dharankar wrote:
> Matt, thanks for the pointers!
> 
> Looking at those sites, it appears that the development at
> "http://lists.insecure.org/lists/linux-kernel/2003/Feb/0987.html."
> which I had pointed is based on the SGI's dump scheme. Same
> for the one you pointed to.
> 
> The other scheme I poinited to (from Mission Critical Linux/MCLX)
> seems to have some strong points too. Any pointers to discussions
> about why the LKCD work seems to more active than the
> MCLX one?

I don't think there has been such a discussion. The Mission Critical
hackers were hired by RedHat and Dave Anderson continues to work on
crash and making it available at:

	ftp://people.redhat.com/anderson

He's had about a release per month. I thought MCLX crash has some
strong points also. After I enhanced LKCD to support the ia64 I
fixed MCLX crash so it could read the new LKCD crash dumps which
are no longer monotonically increasing in memory. I did this to
support NUMA systems which can have more memory than swap space.
This way the most important memory can be saved first. 

If you read the lkcd-devel mailing list you can read our discussion
on maintaining MLCX crash on the lkcd cvs tree. 


	"And imnsho, debugging the kernel on a source 
	 level is the way to do it."
					Linus
					
-piet
	
> 
> Best regards,
> -Arun.
> 
> 
> On Tuesday 08 April 2003 07:14 pm, Matt D. Robinson wrote:
> > Please look at the lkcd-devel mailing archives.  There is
> > at least one group working on a PPC port of LKCD
> >
> > 	http://sourceforge.net/mail/?group_id=2726
> >
> > --Matt
> >
> > On Tue, 2003-04-08 at 13:47, Arun Dharankar wrote:
> > > Greetings.
> > >
> > > >From what I able to find from some searching around, the implementation
> > >
> > > by MCLX ("http://oss.missioncriticallinux.com/projects/mcore/") is being
> > > carried on at
> > > http://lists.insecure.org/lists/linux-kernel/2003/Feb/0987.html.
> > >
> > > Looking at these patches, I can only see x86 architecture support for
> > > in memory kernel crash dump support. Is anyone actively working on the
> > > PowerPC architecture?
> > >
> > > Best regards,
> > > -Arun.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
piet@www.piet.net


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263207AbTDIMQK (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 08:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263286AbTDIMQK (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 08:16:10 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:44246 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP id S263207AbTDIMQG (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 08:16:06 -0400
From: Arun Dharankar <ADharankar@ATTBI.Com>
To: Piet Delaney <piet@www.piet.net>
Subject: Re: Linux kernel crash dumps (LKCD) and PowerPC ports.
Date: Wed, 9 Apr 2003 08:26:36 -0400
User-Agent: KMail/1.5
Cc: piet <piet@www.piet.net>, "Matt D. Robinson" <yakker@alacritech.com>,
       linux-kernel@vger.kernel.org, Dave Anderson <anderson@redhat.com>
References: <200304081647.32146.ADharankar@ATTBI.Com> <200304082349.27844.ADharankar@ATTBI.Com> <1049875702.22212.6634.camel@www.piet.net>
In-Reply-To: <1049875702.22212.6634.camel@www.piet.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304090826.36304.ADharankar@ATTBI.Com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Piet, thanks for the reply!

Some of the points that I found attractive (among other points):

  - Overall a smaller time to reboot and save the dump, and bring the
    system back to working state.
  - Does not require local disk to save the dump on the way down during
    a panic - works on a diskless system.
  - No need for a dump/swap device.


Looking at the MCLX site, the last patch is on 2.4.17 only. Also, the
PowerPC port is a bit broken. Is anyone maintaining this part of the
MCLX scheme, and is available else where?


Best regards,
-Arun.


> > Looking at those sites, it appears that the development at
> > "http://lists.insecure.org/lists/linux-kernel/2003/Feb/0987.html."
> > which I had pointed is based on the SGI's dump scheme. Same
> > for the one you pointed to.
> >
> > The other scheme I poinited to (from Mission Critical Linux/MCLX)
> > seems to have some strong points too. Any pointers to discussions
> > about why the LKCD work seems to more active than the
> > MCLX one?
>
> I don't think there has been such a discussion. The Mission Critical
> hackers were hired by RedHat and Dave Anderson continues to work on
> crash and making it available at:
>
> 	ftp://people.redhat.com/anderson
>
> He's had about a release per month. I thought MCLX crash has some
> strong points also. After I enhanced LKCD to support the ia64 I
> fixed MCLX crash so it could read the new LKCD crash dumps which
> are no longer monotonically increasing in memory. I did this to
> support NUMA systems which can have more memory than swap space.
> This way the most important memory can be saved first.
>
> If you read the lkcd-devel mailing list you can read our discussion
> on maintaining MLCX crash on the lkcd cvs tree.
>
>
> 	"And imnsho, debugging the kernel on a source
> 	 level is the way to do it."
> 					Linus
>
> -piet
>
> > Best regards,
> > -Arun.
> >
> > On Tuesday 08 April 2003 07:14 pm, Matt D. Robinson wrote:
> > > Please look at the lkcd-devel mailing archives.  There is
> > > at least one group working on a PPC port of LKCD
> > >
> > > 	http://sourceforge.net/mail/?group_id=2726
> > >
> > > --Matt


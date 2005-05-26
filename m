Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbVEZScX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbVEZScX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 14:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVEZScX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 14:32:23 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:46546 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261687AbVEZScU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 14:32:20 -0400
Subject: Re: 2.6.12-rc5-mm1 alsa oops
From: Lee Revell <rlrevell@joe-job.com>
To: Borislav Petkov <petkov@uni-muenster.de>
Cc: pharon@gmail.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200505262012.45833.petkov@uni-muenster.de>
References: <1117092768.26173.4.camel@localhost>
	 <200505261944.50942.petkov@uni-muenster.de>
	 <1117130470.5477.5.camel@mindpipe>
	 <200505262012.45833.petkov@uni-muenster.de>
Content-Type: text/plain
Date: Thu, 26 May 2005 14:32:19 -0400
Message-Id: <1117132339.5477.20.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-26 at 20:12 +0200, Borislav Petkov wrote:
> On Thursday 26 May 2005 20:01, Lee Revell wrote:
> > On Thu, 2005-05-26 at 19:44 +0200, Borislav Petkov wrote:
> > > <snip>
> > >
> > > Andrew,
> > >
> > > similar oopses as the one I'm replying to all over the place. At it
> > > happens m in snd_pcm_mmap_data_close(). Here's a stack trace:
> >
> > No one using ALSA CVS or any of the 1.0.9 release candidates ever
> > reported this, but lots of -mm users are... does that help at all?  I
> > suspect some upstream bug that ALSA just happens to trigger.
> yeah,
> 
> this has to do with alsa indirectly. snd_pcm_mmap_data_close() accesses some 
> vm_area_struct->vm_private_data and apparently there have been some 
> optimizations to mmap code to avoid fragmentation of vma's so i think there's 
> the problem. However, we'll need the smarter ones here :))

Any idea which patches to back out?

Lee


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSEEQgU>; Sun, 5 May 2002 12:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313182AbSEEQgT>; Sun, 5 May 2002 12:36:19 -0400
Received: from smtp02.web.de ([217.72.192.151]:29720 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S313181AbSEEQgS>;
	Sun, 5 May 2002 12:36:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Sebastian Huber <sebastian-huber@web.de>
To: linux-kernel@vger.kernel.org
Subject: Re: modversion.h improvement suggestion
Date: Sun, 5 May 2002 18:36:34 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.GSO.4.05.10205051818350.20954-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E174Ozd-0007QI-00@smtp.web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 May 2002 18:19, you wrote:
> On Sun, 5 May 2002, Sebastian Huber wrote:
> > Hello,
> > I tried to compile a device driver module and got the error that
> > 'modversion.h' cannot be found. My first questions were:
> > 	Are the include paths ok?
> > 	Do the maintainer now what he or she is doing?
> > 	Uses this driver code obsolete kernel stuff?
> > 	Has SuSE forgotten something to install?
> > Then I started a google search for 'modversion.h' and noticed that this
> > was a common problem. And after a while I found the solution ->
> > modversion.h is an automatically generated file.
> >
> > So what about a default modversion.h file:
> > /* This is an automatically generated file. Do not edit it. */
> > #error You have not generated the module versions. You have to ...
> >
> > This hint may save some time for those who are not so fit in kernel
> > issues.
>
> you should include module.h in any case - this also includes modversions.h
> (if you compile your kernel/module with MODVERSIONS enabled)
>
> 	++dent

They include modules.h, but if modversion.h doesn't exist you get of course 
the error that the file cannot be found. And if you don't play every day with 
the kernel this information alone don't help you very much. So an appropriate 
message might help you.

PS:
I'm not a member of this mailing list, so please cc me mails related to that 
subject.


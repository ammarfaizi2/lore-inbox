Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132130AbRDJPMQ>; Tue, 10 Apr 2001 11:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132186AbRDJPMI>; Tue, 10 Apr 2001 11:12:08 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:53522 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S132130AbRDJPLy>; Tue, 10 Apr 2001 11:11:54 -0400
Message-Id: <200104101511.f3AFBks31940@aslan.scsiguy.com>
To: "Jeffrey W. Baker" <jwbaker@acm.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Seems to be a lot of confusion about aic7xxx in linux 2.4.3 
In-Reply-To: Your message of "Fri, 06 Apr 2001 08:09:36 PDT."
             <Pine.LNX.4.33.0104060803450.12216-100000@heat.gghcwest.com> 
Date: Tue, 10 Apr 2001 09:11:46 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I've been seeing a lot of complaints about aic7xxx in the 2.4.3 kernel.  I
>think that people are missing the crucial point: aic7xxx won't compile if
>you patch up from 2.4.2, but if you download the complete 2.4.3 tarball,
>it compiles fine.
>
>So, I conclude that the patch was created incorrectly, or that something
>changed between cutting the patch and the tarball.
>
>-jwb

Actually, the issue has to do with how the firmware is generated and
the dependencies between generated and source files.  The tar file
touched all files whereas the patch touched only a few.  This is why
the tar file worked and the patch did not.

Newer versions of the driver completely avoid this issue by only attempting
to re-build the firmware if you explicitly configure your kernel this way.

--
Justin

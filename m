Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314074AbSDVHKx>; Mon, 22 Apr 2002 03:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314078AbSDVHKw>; Mon, 22 Apr 2002 03:10:52 -0400
Received: from pc3-camc5-0-cust13.cam.cable.ntl.com ([80.4.125.13]:33469 "EHLO
	fenrus.demon.nl") by vger.kernel.org with ESMTP id <S314074AbSDVHKu>;
	Mon, 22 Apr 2002 03:10:50 -0400
Date: Mon, 22 Apr 2002 08:06:47 +0100
Message-Id: <200204220706.g3M76lm32442@fenrus.demon.nl>
From: arjan@fenrus.demon.nl
To: Suparna Bhattacharya <suparna@in.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Bio pool & scsi scatter gather pool usage
In-Reply-To: <3CC3B2AA.80217EA0@in.ibm.com>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.9-31 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3CC3B2AA.80217EA0@in.ibm.com> you wrote:

> or maybe have a way pass back an error to retry with smaller size.
> Maybe 2 limits (one that indicates that anything bigger than this is
> sure to
> get split, so always break it up, and another that says that anything
> smaller
> than this is sure not to be split, so use this size when you can't
> afford a
> split).

Unfortionatly it's not always size that's the issue. For example in my
code I need to split when a request crosses a certain boundary, and without 
going into too much detail, that boundary is 62 Kb aligned, not 64
(for technical reasons ;(). 

Size won't catch this and while a 64Kb Kb block will always be split, that
you can be sure of, even a 4Kb request, if unlucky, can have the need to
split up.


-- 
But when you distribute the same sections as part of a whole which is a work 
based on the Program, the distribution of the whole must be on the terms of 
this License, whose permissions for other licensees extend to the entire whole,
and thus to each and every part regardless of who wrote it. [sect.2 GPL]

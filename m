Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271963AbRHVST1>; Wed, 22 Aug 2001 14:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271931AbRHVSTS>; Wed, 22 Aug 2001 14:19:18 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:40459 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S271963AbRHVSS5>; Wed, 22 Aug 2001 14:18:57 -0400
Message-ID: <3B83F79E.45B9CC34@zip.com.au>
Date: Wed, 22 Aug 2001 11:19:10 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-ac8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Meadors <clubneon@hereintown.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops after mounting ext3 on 2.4.8-ac9
In-Reply-To: <Pine.LNX.4.31.0108221042430.3959-100000@rc.priv.hereintown.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Meadors wrote:
> 
> Upon issuing "mount -avt nonfs" at boot, my machine oopsed while mounting
> the last partition in the fstab.

USB problem.  Looks like dev->bus has a wild value in new_dev_inode().
>From a quick scan I don't see any changes in ac8->ac9 which could cause
this.  Please, work back through kernel versions until it goes away and
let us know.

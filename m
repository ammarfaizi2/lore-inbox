Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284956AbRLFDEk>; Wed, 5 Dec 2001 22:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284955AbRLFDEa>; Wed, 5 Dec 2001 22:04:30 -0500
Received: from dsl-213-023-038-088.arcor-ip.net ([213.23.38.88]:47376 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S284952AbRLFDEO>;
	Wed, 5 Dec 2001 22:04:14 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Nathan Scott <nathans@sgi.com>, Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>, Andi Kleen <ak@suse.de>,
        Andreas Gruenbacher <ag@bestbits.at>
Subject: Re: [PATCH] Revised extended attributes interface
Date: Thu, 6 Dec 2001 04:05:32 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@oss.sgi.com
In-Reply-To: <20011205143209.C44610@wobbly.melbourne.sgi.com>
In-Reply-To: <20011205143209.C44610@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Boqr-0000m9-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 5, 2001 04:32 am, Nathan Scott wrote:
> Here is the revised interface.  I believe it takes into account
> the issues raised so far - further suggestions are also welcome,
> of course.

Hi Nathan,

I still don't like the class parsing inside the kernel, it's hard to see
what is good about that.

Is there a difference between these two?:

   long sys_setxattr(char *path, char *name, void *value, size_t size, int flags)
   long sys_lsetxattr(char *path, char *name, void *value, size_t size, int flags)

--
Daniel

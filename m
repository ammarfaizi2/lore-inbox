Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267548AbUHPLm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267548AbUHPLm5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 07:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267549AbUHPLm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 07:42:57 -0400
Received: from shockwave.systems.pipex.net ([62.241.160.9]:16059 "EHLO
	shockwave.systems.pipex.net") by vger.kernel.org with ESMTP
	id S267548AbUHPLm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 07:42:56 -0400
Message-ID: <41209DBB.1060909@tungstengraphics.com>
Date: Mon, 16 Aug 2004 12:42:51 +0100
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Airlie <airlied@linux.ie>
Cc: Arjan van de Ven <arjanv@redhat.com>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: DRM and 2.4 ...
References: <Pine.LNX.4.58.0408160652350.9944@skynet> <1092640312.2791.6.camel@laptop.fenrus.com> <412081C6.20601@tungstengraphics.com> <20040816094622.GA31696@devserv.devel.redhat.com> <412088A5.6010106@tungstengraphics.com> <20040816101426.GB31696@devserv.devel.redhat.com> <Pine.LNX.4.58.0408161137330.21177@skynet>
In-Reply-To: <Pine.LNX.4.58.0408161137330.21177@skynet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie wrote:
>>DRM_IOCTL_ARGS, DRM_ERR, DRM_CURRENTPID, DRM_UDELAY, DRM_READMEMORYBARRIER,
>>DRM_COPY_FROM_USER_IOCTL etc etc existed prior to freebsd support? Oh my
>>god...

Heh.  I actually find those ones pretty innocuous and easy to work with, 
compared to some of the stuff in there.  Nothing that etags can't disambiguate 
for you.

What's more challenging is are the macros defined in the drivers which then 
customize the behaviour of shared header files - these are really the 
challenging aspect to working with that code, and what Dave has been working 
to remove.

> I'm currently open for constructive critics with ideas on how to fix these
> things, the DRM is open for business if we can fix things up now it will
> be a lot easier while I'm knee deep with time than after I'm finished and
> back travelling .. should we have try to implement Linux fns in BSD, what
> do we do if more parameters/info are needed from a BSD side, or do we try
> and sideline all these into a separate library of functions and wrap them
> on both bsd and linux?

Dave's hit the nail on the head here.  If you'd like some changes, feel free 
to make suggestions.

The macros you outline aren't great, but they aren't the real impediment to 
working with/understanding drm either.  But if we can fix that stuff up at the 
same time, why not?

Keith


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263239AbTDCCnI>; Wed, 2 Apr 2003 21:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263244AbTDCCnI>; Wed, 2 Apr 2003 21:43:08 -0500
Received: from mail.casabyte.com ([209.63.254.226]:58637 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP
	id <S263239AbTDCCnH>; Wed, 2 Apr 2003 21:43:07 -0500
From: "Robert White" <rwhite@casabyte.com>
To: "Christoph Rohland" <cr@sap.com>, <tomlins@cam.org>
Cc: "CaT" <cat@zip.com.au>, <linux-kernel@vger.kernel.org>,
       "Hugh Dickins" <hugh@veritas.com>
Subject: RE: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
Date: Wed, 2 Apr 2003 18:54:27 -0800
Message-ID: <PEEPIDHAKMCGHDBJLHKGAEOMCFAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <ovk7eekwsc.fsf@sap.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This (using swap as part of the tmpfs type system) is what happens on a Sun.
I was disappointed (surprised even) in the Linux implementations because
mounting a truly temporary /tmp was what I wanted it for.

I would like to see a tmpfs (swapfs?) that did presume that files not in use
(lately?) would migrate out of my valuable RAM and onto the super-cheap swap
device.

IMHO of course.

Rob.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Christoph
Rohland
Sent: Tuesday, April 01, 2003 8:28 AM
To: tomlins@cam.org
Cc: CaT; linux-kernel@vger.kernel.org; Hugh Dickins
Subject: Re: PATCH: allow percentile size of tmpfs (2.5.66 /
2.4.20-pre2)


Hi Ed,

On Tue, 01 Apr 2003, Ed Tomlinson wrote:
> What does tmpfs have to do with ram size?  Its swappable.  This
> _might_ be useful for ramfs but for tmpfs, IMHO, its not a good
> idea.

I agree and I think if you add this option it should adjust to a
percentage of (ram + swap). With this it would be a really nice
improvement.
I even had patches for this but to do it efficently you would need to
add some hooks to swapon and swapoff.

Greetings
		Christoph


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262220AbRE0Ukv>; Sun, 27 May 2001 16:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262212AbRE0Ukm>; Sun, 27 May 2001 16:40:42 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:30064 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S262195AbRE0Uk2>; Sun, 27 May 2001 16:40:28 -0400
Date: Sun, 27 May 2001 16:40:18 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: Edgar Toernig <froese@gmx.de>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD 
 w/info-PATCH]device arguments from lookup)
In-Reply-To: <3B1101ED.3BF181F6@gmx.de>
Message-ID: <Pine.LNX.4.33.0105271626500.15241-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 May 2001, Edgar Toernig wrote:

> You really mean that "magicdev" is a directory and:
>
> 	open("magicdev/.", O_RDONLY);

At least for the patch I posted, that would return -ENOTDIR, and exactly
for the reason that not doing so would break find.  I've been convinced
that we really need to be careful which, if any, options are permitted in
this fashion.

		-ben


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263549AbTEYQ6W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 12:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263558AbTEYQ6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 12:58:22 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8200 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263549AbTEYQ6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 12:58:19 -0400
Date: Sun, 25 May 2003 10:10:56 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Adam Sampson <azz@us-lot.org>
cc: Ben Collins <bcollins@debian.org>, Patrick Mochel <mochel@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Resend [PATCH] Make KOBJ_NAME_LEN match BUS_ID_SIZE
In-Reply-To: <y2awugf2pz9.fsf@cartman.at.fivegeeks.net>
Message-ID: <Pine.LNX.4.44.0305251008490.21192-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 25 May 2003, Adam Sampson wrote:
> 
> If you're going to do this, it might make sense to call it "strlcpy"
> for consistency with the OpenBSD-introduced function of the same name
> that's getting included in a lot of userspace these days...

Sure, done. I'll check it in asap (and I'll make the devfs parts that Ben 
was unhappy about use it too).

Somebody (else ;) should probably go through our current uses of strncpy()  
and see if they make sense. Some of them probably do, but I suspect 
anything name/path related does not.

		Linus


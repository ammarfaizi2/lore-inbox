Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269489AbRHQCnN>; Thu, 16 Aug 2001 22:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269494AbRHQCnD>; Thu, 16 Aug 2001 22:43:03 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:16903 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id <S269489AbRHQCmr>;
	Thu, 16 Aug 2001 22:42:47 -0400
Message-ID: <3B7C8196.10D1C867@linux-m68k.org>
Date: Fri, 17 Aug 2001 04:29:42 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: aia21@cam.ac.uk, tpepper@vato.org, f5ibh@db0bm.ampr.org,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.9 does not compile [PATCH]
In-Reply-To: <5.1.0.14.2.20010816234350.00add710@pop.cus.cam.ac.uk>
		<20010816.163852.115909286.davem@redhat.com>
		<3B7C7235.1E09C034@linux-m68k.org> <20010816.185018.102580124.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"David S. Miller" wrote:

> That is a legitimate operation, there is no reason to prevent people
> from comparing signed and unsigned values.  These type argument
> min/max values allow people to specify what the comparison type
> degenerates into.

Sure, but if people change something, they get a warning and can think
_again_, your current macro prevents this. That hardcoded type is just
to easy to miss and can introduce subtle bugs. The typeof version
automatically chooses that largest of the types and possibly warns you.
Why would you want something different?

bye, Roman

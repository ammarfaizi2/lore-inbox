Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261507AbRENHf0>; Mon, 14 May 2001 03:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261925AbRENHfR>; Mon, 14 May 2001 03:35:17 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:47624 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261840AbRENHfB>; Mon, 14 May 2001 03:35:01 -0400
Date: 14 May 2001 09:05:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Message-ID: <80qQpWhmw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.21.0105131330350.20613-100000@penguin.transmeta.com>
Subject: Re: page_launder() bug
X-Mailer: CrossPoint v3.12d.kh6 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <Pine.LNX.4.21.0105131330350.20613-100000@penguin.transmeta.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds)  wrote on 13.05.01 in <Pine.LNX.4.21.0105131330350.20613-100000@penguin.transmeta.com>:

> And that's why I'd rather have generic support for _any_ page mapping that
> wants to drop pages early than have specific logic for swapping.
> Historically, we've always had very good results from trying to avoid
> having special cases and instead trying to find what the common rules
> might be.

Just a thought: isn't a dead swap page a rather similar condition to a  
page in a file without any links, open file descriptors, or open mmaps? In  
both cases, writeback really makes no sense.

MfG Kai

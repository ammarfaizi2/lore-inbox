Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291162AbSBLUNf>; Tue, 12 Feb 2002 15:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291164AbSBLUNQ>; Tue, 12 Feb 2002 15:13:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64273 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291162AbSBLUNG>;
	Tue, 12 Feb 2002 15:13:06 -0500
Message-ID: <3C69771E.17F26646@zip.com.au>
Date: Tue, 12 Feb 2002 12:12:14 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Larson <davlarso@acm.org>
CC: linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de
Subject: Re: Is this a bug in TCP or the PCNet32 driver?
In-Reply-To: <Pine.GSO.4.31.0202120728000.24018-100000@linus.davelarson.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Larson wrote:
> 
> The way things are today, the TCP code rely on the hardware drivers to
> free an skb as soon as it is transmitted. But in that case of PCNet32,
> that doesn't happen. On the other hand, PCNet32 does seem reasonable in
> it's attempts to reduce the number of interrupts, although that breaks the
> tcp code in this case were these isn't much network activity.
> 

Yup.  Tx interrupt mitigation like this is a really neat feature. It
can make a huge improvement in performance.  But the driver does need
to implement a timer to fix the problem which you have described.

-

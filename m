Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262044AbVFQSIC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbVFQSIC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 14:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbVFQSIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 14:08:02 -0400
Received: from CPE000f6690d4e4-CM00003965a061.cpe.net.cable.rogers.com ([69.193.74.134]:26628
	"EHLO tentacle.dhs.org") by vger.kernel.org with ESMTP
	id S262042AbVFQSHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 14:07:46 -0400
Date: Fri, 17 Jun 2005 14:15:01 -0400
To: Zach Brown <zab@zabbo.net>
Cc: Robert Love <rml@novell.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] inotify, improved.
Message-ID: <20050617181501.GB2220@tentacle.dhs.org>
References: <1118855899.3949.21.camel@betsy> <42B1BC4B.3010804@zabbo.net> <1118946334.3949.63.camel@betsy> <42B227B5.3090509@yahoo.com.au> <1118972109.7280.13.camel@phantasy> <1119021336.3949.104.camel@betsy> <42B30654.4030307@zabbo.net> <20050617175455.GA1981@tentacle.dhs.org> <42B30EC1.60608@zabbo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B30EC1.60608@zabbo.net>
User-Agent: Mutt/1.5.9i
From: John McCutchan <ttb@tentacle.dhs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2005 at 10:56:17AM -0700, Zach Brown wrote:
> John McCutchan wrote:
> 
> > I really don't like sending partial events. 
> 
> Partial reads, not partial events.  Just like the previous code, it
> returns to userspace after copying the events it found in the list
> before it went empty.  It doesn't go back to sleep to fill the rest of
> the buffer like a more classical blocking read() method would.
> 
> Where it differs is in what happens if you get errors copying events
> after having successfully copied some.  The previous code would return
> the error, that patch would return the bytes used by the good events.

My bad. Shouldn't we return the error code to user space though? We
shouldn't be hiding errors in the app. How does read() handle an error
part way through a read?

John

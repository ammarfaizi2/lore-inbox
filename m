Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263838AbTDIVz2 (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 17:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263839AbTDIVz2 (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 17:55:28 -0400
Received: from almesberger.net ([63.105.73.239]:15373 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S263838AbTDIVz1 (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 17:55:27 -0400
Date: Wed, 9 Apr 2003 19:07:00 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Frank Davis <fdavis@si.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel support for non-english user messages
Message-ID: <20030409190700.H19288@almesberger.net>
References: <3E93A958.80107@si.rr.com> <20030409080803.GC29167@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030409080803.GC29167@mea-ext.zmailer.org>; from matti.aarnio@zmailer.org on Wed, Apr 09, 2003 at 11:08:03AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio wrote:
> In the old days of big iron beasts, there used to be multivolume
> binders full of system messages,

... and in the modern age, we have Perl and regexps :-)

Nobody is going to maintain all the translations of "his" component,
so you might as well let the translators try to play catch-up, and
track changes in their regexp database.

For the kernel, we don't have the mechanisms of big companies or
monolithic projects to just funnel all changes of a specific kind
through a single channel, where somebody slaps a unique message-id
on them.

Granted, you can have multi-level messages (like the VMS-style
%facility-severity-ident), but that only buys some time. And you
still either need a message catalog or include the plain text in
the message as well.

The message catalog only approach wouldn't work well for the kernel,
yielding either too many files or patch congestion on central
message files. Think of Documentation/Configure.help and the
relative frequency of changes.

And if you have the (English) plain text, you almost always also
have your unique message key. At least unique enough for
translation. So perhaps it's time to forget the traditional
solutions, and think of a more distributed approach.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/

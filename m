Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263624AbTFJRMB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 13:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263628AbTFJRMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 13:12:00 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:35339 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263624AbTFJRMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 13:12:00 -0400
Date: Tue, 10 Jun 2003 19:25:40 +0200
From: Martin Mares <mj@ucw.cz>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Large files
Message-ID: <20030610172540.GA5178@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.53.0306100952560.4080@chaos> <20030610141759.GU28900@mea-ext.zmailer.org> <Pine.LNX.4.53.0306101057020.4326@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0306101057020.4326@chaos>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> On the system that fails, there are no ulimits and it's the root
> account, therefore I don't know how to set the above limit to
> RLIM_INFINITY (~0LU).  It's also version  2.4.20. I don't think
> it has anything to do with 'rlim' shown above.

I think it has -- login (or PAM) in most distributions sets the
file size limit to 2GB instead of RLIM_INFINITY. If you are root,
try `ulimit -f unlimited' to see if it helps.

> sending a signal when the file-size exceeds some level is preposterous.

No, it's just the definition of the rlimits. Not leaving them at
RLIM_INFINITY by default is preposterous.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
COBOL -- Compiles Only Because Of Luck

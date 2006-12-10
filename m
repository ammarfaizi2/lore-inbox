Return-Path: <linux-kernel-owner+w=401wt.eu-S934488AbWLJVuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934488AbWLJVuE (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 16:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934487AbWLJVuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 16:50:03 -0500
Received: from smtp-vbr16.xs4all.nl ([194.109.24.36]:1303 "EHLO
	smtp-vbr16.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934422AbWLJVuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 16:50:00 -0500
Date: Sun, 10 Dec 2006 22:49:54 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: Re: strncpy optimalisation? (lib/string.c)
Message-ID: <20061210214954.GG30197@vanheusden.com>
References: <20061210205230.GB30197@vanheusden.com>
	<20061210210614.GD24090@1wt.eu>
	<20061210213518.GD30197@vanheusden.com>
	<20061210220507.GE47959@gaz.sfgoth.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061210220507.GE47959@gaz.sfgoth.com>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Mon Dec 11 21:32:58 CET 2006
X-Message-Flag: www.unixexpert.nl
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This one (tested in test-code seperate from kernel) works:
> No it doesn't!
> strncpy() guarantees that the entire destination buffer is written to.
> If you call
> 	strncpy(dest, "foo", 10000)
> then you MUST write to 10000 bytes of memory, or your strncpy() is buggy.
> Your patches basically turn strncpy() into strlcpy().  Don't do that.
> They're separate functions for a reason.

Yes I saw that, didn't read your e-mail before I read Willy's message.

Can you please also have a look at my strlcpy patch?


Folkert van Heusden

-- 
www.vanheusden.com/recoverdm/ - got an unreadable cd with scratches?
                            recoverdm might help you recovering data
--------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263512AbTIHVLV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 17:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263553AbTIHVLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 17:11:21 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:1796 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263512AbTIHVLU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 17:11:20 -0400
Message-ID: <3F5CF045.DDDE475C@SteelEye.com>
Date: Mon, 08 Sep 2003 17:10:29 -0400
From: Paul Clements <Paul.Clements@SteelEye.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sven =?iso-8859-1?Q?K=F6hler?= <skoehler@upb.de>
CC: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [NBD] patch and documentation
References: <3F5CB554.5040507@upb.de> <20030908193838.GA435@elf.ucw.cz> <3F5CE0E5.A5A08A91@SteelEye.com> <3F5CE3E6.8070201@upb.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Köhler wrote:
 
> Well, i guess the cache uses a value of 256 sectors to do read-ahead and
> such.

Well it sounds like the real problem here is the vm_max_readahead
setting then. Try this:

cat /proc/sys/vm/max-readahead

Probably, it's set to 31 on your system.

Try something like the following:

echo "126" > /proc/sys/vm/max-readahead

I think that should help out.

--
Paul

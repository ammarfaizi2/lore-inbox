Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264085AbUECWBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbUECWBp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 18:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264088AbUECWBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 18:01:45 -0400
Received: from mailgate2.mysql.com ([213.136.52.47]:23515 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S264085AbUECWBm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 18:01:42 -0400
Subject: Re: Random file I/O regressions in 2.6
From: Peter Zaitsev <peter@mysql.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au, alexeyk@mysql.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
In-Reply-To: <1083621052.7949.53.camel@localhost.localdomain>
References: <200405022357.59415.alexeyk@mysql.com>
	 <409629A5.8070201@yahoo.com.au> <20040503110854.5abcdc7e.akpm@osdl.org>
	 <1083615727.7949.40.camel@localhost.localdomain>
	 <20040503135719.423ded06.akpm@osdl.org>
	 <1083620245.23042.107.camel@abyss.local>
	 <1083621052.7949.53.camel@localhost.localdomain>
Content-Type: text/plain
Organization: MySQL
Message-Id: <1083621680.23040.120.camel@abyss.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 03 May 2004 15:01:21 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-03 at 14:50, Ram Pai wrote:

> 
> Looking at it the other way, without readahead code, all requests
> satisfied through 4k i/os.  Readahead helps in generating larger size
> i/os.

Huh,  This is kind of really strange.


If you speak about database world, Random IO is quite frequent and
database page sizes are normally larger than OS page size.

Furthermore even if it is split to 4K block sizes, why are they not
submitted in parallel, being merged on lower level.

Anyway we seems to all agree this is not very good behavior and it
should be fixed :)



-- 
Peter Zaitsev, Senior Support Engineer
MySQL AB, www.mysql.com




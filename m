Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264061AbUGFQD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264061AbUGFQD5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 12:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUGFQD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 12:03:57 -0400
Received: from rzfoobar.is-asp.com ([217.11.194.155]:62084 "EHLO mail.isg.de")
	by vger.kernel.org with ESMTP id S264061AbUGFQDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 12:03:55 -0400
Message-ID: <40EACC0C.6060606@isg.de>
Date: Tue, 06 Jul 2004 17:58:04 +0200
From: Lutz Vieweg <lkv@isg.de>
Organization: Innovative Software AG
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040322 wamcom.org
X-Accept-Language: de, German, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: How to find out which pages were copied-on-write?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

in an application that MAP_PRIVATEly mmap()s a file it would
be quite helpful for me to find out which pages have been
copied-on-write.

I found that mincore() does a similar thing by reporting which
pages are currently residing in physical memory, but what
I want to know is which pages differ from the original file
image on disk.

Can you recommend a way to do that? (does not need to be
portable beyond Linux)

Alternatively, it would be sufficient if I could turn
a private mapping into a shared one (and possibly do an
msync() afterwards if I need to make sure the changes
have been written out). Would such a feature need a
lot of effort to implement?


Yet another feature that I could use if it were available:
A "copy-on-read"-mapping. There, a page would become a private
copy of a process once _another_ process wrote data to the
corresponding file location. But I suspect that feature
could be very hard to implement...

Regards,

Lutz Vieweg



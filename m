Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286620AbRLUXBy>; Fri, 21 Dec 2001 18:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286621AbRLUXBo>; Fri, 21 Dec 2001 18:01:44 -0500
Received: from ns.marxmeier.com ([194.64.71.4]:9994 "EHLO e35.marxmeier.com")
	by vger.kernel.org with ESMTP id <S286620AbRLUXBd>;
	Fri, 21 Dec 2001 18:01:33 -0500
Message-ID: <3C23BF4B.70BDABBE@marxmeier.com>
Date: Sat, 22 Dec 2001 00:01:31 +0100
From: Michael Marxmeier <mike@marxmeier.com>
Organization: Marxmeier Software AG
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Question on sys_readahead()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a question on sys_readahead and would appreciate 
some hint or a pointer.

- When was this call added?

- As far as i understand the code it reads the data into 
  the page cache. The data is ready sync and there is no
  way to do this async and have a notification unless using
  a separate thread.

A typical use i could see is preloading some data in the
page cache from a separate thread (eg. for a media player).

BTW: AFAICS the code is off by one if offset/count is not in 
PAGE_SIZE chunks? 

  unsigned long start = offset >> PAGE_CACHE_SHIFT;
  unsigned long len = (count + ((long)offset & ~PAGE_CACHE_MASK)) >> PAGE_CACHE_SHIFT;


Thanks
Michael

-- 
Michael Marxmeier           Marxmeier Software AG
E-Mail: mike@marxmeier.com  Besenbruchstrasse 9
Phone : +49 202 2431440     42285 Wuppertal, Germany
Fax   : +49 202 2431420     http://www.marxmeier.com/

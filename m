Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965025AbWEYFef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbWEYFef (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 01:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbWEYFef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 01:34:35 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:39302 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965025AbWEYFee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 01:34:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=WYUnrerP9gM3cW+PqOlWA+XP+Htc6D8A75hOeBFLgBaBOUWtC5Z+WMB2TbC6RloAj7DHx7M4ugoa86CGLNSTlitQ+x1CXyYz/oYPOvlKzDEslC916yBGYpojtOi1XRrrdNRsCKC+ZGRck/xshX2F8vE7eKBXZwmV14XEYncoTQE=  ;
Message-ID: <447541E6.4090702@yahoo.com.au>
Date: Thu, 25 May 2006 15:34:30 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/33] readahead: initial method
References: <20060524111246.420010595@localhost.localdomain> <348469546.16482@ustc.edu.cn>
In-Reply-To: <348469546.16482@ustc.edu.cn>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW. while your patchset might be nicely broken down, I think your
naming and descriptions are letting it down a little bit.

Wu Fengguang wrote:

>Aggressive readahead policy for read on start-of-file.
>
>Instead of selecting a conservative readahead size,
>it tries to do large readahead in the first place.
>
>However we have to watch on two cases:
>	- do not ruin the hit rate for file-head-checkers
>	- do not lead to thrashing for memory tight systems
>
>

How does it handle
             -  don't needlessly readahead too much if the file is in cache


Would the current readahead mechanism benefit from more aggressive 
start-of-file
readahead?

--

Send instant messages to your online friends http://au.messenger.yahoo.com 

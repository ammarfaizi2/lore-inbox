Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbUKAFii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbUKAFii (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 00:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbUKAFii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 00:38:38 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:728 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261280AbUKAFig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 00:38:36 -0500
Message-ID: <4185CBDC.6090502@namesys.com>
Date: Sun, 31 Oct 2004 21:38:36 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: linux-kernel@vger.kernel.org, Vladimir Demidov <demidov@namesys.com>
Subject: Re: readdir loses renamed files
References: <431547F9-2624-11D9-8AC3-000393CC2E90@iki.fi> <20041025123722.GA5107@thunk.org> <20041028093426.GB15050@merlin.emma.line.org> <20041028114413.GL1343@schnapps.adilger.int> <4182B2FF.9040902@namesys.com> <Pine.LNX.4.53.0410292326300.8389@yvahk01.tjqt.qr> <4183E775.3090701@namesys.com> <Pine.LNX.4.53.0410310726060.3581@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0410310726060.3581@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:

>>>>It should be possible to perform an atomic readdir if that is what you
>>>>want to do and if you have space in your process to stuff the result.
>>>>        
>>>>
>>>How much would it cost to always append the new name into the directory rather
>>>than modifying it in place?
>>>      
>>>
>>Forgive me, what does the sentence above mean?  Paste it out of order?
>>    
>>
>
>As I have read from earlier replies, ext2/3 replaces a filename with the new
>one, given that it is the same length or shorter, and especially that might
>skip a while when readdir()ing.
>So I was concerned about the speed impact which would arise, if the filename
>was never modified in-place but always appended as a new object to the
>end-of-directory.
>
>
>
>Jan Engelhardt
>  
>
The api is fundamentally broken.  Sorry.   Will try to avoid making that 
mistake in sys_reiser4.

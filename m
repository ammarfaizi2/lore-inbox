Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbVHWTWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbVHWTWK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 15:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbVHWTWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 15:22:10 -0400
Received: from intranet.networkstreaming.com ([24.227.179.66]:45168 "EHLO
	networkstreaming.com") by vger.kernel.org with ESMTP
	id S932316AbVHWTWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 15:22:09 -0400
Message-ID: <430B077A.10700@davyandbeth.com>
Date: Tue, 23 Aug 2005 06:24:42 -0500
From: Davy Durham <pubaddr2@davyandbeth.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050322
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org
Subject: Re: select() efficiency / epoll
References: <42E162B6.2000602@davyandbeth.com> <20050722212454.GB18988@outpost.ds9a.nl> <430AF11A.5000303@davyandbeth.com> <20050823182405.GA21301@outpost.ds9a.nl> <430B01FB.2070903@davyandbeth.com> <20050823191254.GB10110@alpha.home.local>
In-Reply-To: <20050823191254.GB10110@alpha.home.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Aug 2005 19:21:41.0687 (UTC) FILETIME=[E43D6470:01C5A817]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That's probably a good idea.  Where would I find out what other projects 
use it?

Willy Tarreau wrote:

>Hi,
>
>On Tue, Aug 23, 2005 at 06:01:15AM -0500, Davy Durham wrote:
>  
>
>>I just mean that when  I debug and catch the segv, it's dies because 
>>some pointers now have corrupted values.  (usually because something is 
>>overwriting some memory some where)
>>
>>I'm currently re-writing some code to make it use select() instead of 
>>epoll_wait() and see if everything is suddently fixed.  If so, then I 
>>will suspect that epoll has a problem.  But it's still not ruled out 
>>being my fault since it could be a timing issue that makes the crash 
>>show up.
>>    
>>
>
>Just out of curiosity, have you had the opportunity to read some other
>code which uses epoll ? Maybe reading others code could enlighten you
>on potential bugs in your code, potential races, etc...
>
>Regards,
>Willy
>  
>


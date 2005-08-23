Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbVHWTuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbVHWTuf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 15:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbVHWTuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 15:50:35 -0400
Received: from intranet.networkstreaming.com ([24.227.179.66]:17535 "EHLO
	networkstreaming.com") by vger.kernel.org with ESMTP
	id S932341AbVHWTue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 15:50:34 -0400
Message-ID: <430B0E28.5090403@davyandbeth.com>
Date: Tue, 23 Aug 2005 06:53:12 -0500
From: Davy Durham <pubaddr2@davyandbeth.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050322
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jari Sundell <sundell.software@gmail.com>
CC: bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org
Subject: Re: select() efficiency / epoll
References: <42E162B6.2000602@davyandbeth.com>	 <20050722212454.GB18988@outpost.ds9a.nl>	 <430AF11A.5000303@davyandbeth.com> <b3f2685905082312301868f00e@mail.gmail.com>
In-Reply-To: <b3f2685905082312301868f00e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Aug 2005 19:50:10.0796 (UTC) FILETIME=[DEF2BAC0:01C5A81B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jari Sundell wrote:

>On 8/23/05, Davy Durham <pubaddr2@davyandbeth.com> wrote:
>  
>
>>However, I'm getting segfaults because some pointers in places are
>>getting set to low integer values (which didn't used to have those values).
>>    
>>
>
>Is it possible that you are overwritting the pointers with file
>descriptors, as those would have low integer values?
>
>  
>
Yes, that is what I was thinking and is why I mentioned that.  But I'm 
apparently not overwriting the pointers with FDs.. it seems that epoll 
is the cause at this point (unless I'm misusing the epoll API).  I've 
made some changes to now use select() instead of epoll and things work 
flawlessly (although it obviously won't work as efficiently when I 
really connect a lot of clients to this server)




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbVHXBJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbVHXBJZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 21:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbVHXBJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 21:09:24 -0400
Received: from intranet.networkstreaming.com ([24.227.179.66]:48060 "EHLO
	networkstreaming.com") by vger.kernel.org with ESMTP
	id S1750791AbVHXBJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 21:09:24 -0400
Message-ID: <430B58AB.2060704@davyandbeth.com>
Date: Tue, 23 Aug 2005 12:11:07 -0500
From: Davy Durham <pubaddr2@davyandbeth.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050322
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jari Sundell <sundell.software@gmail.com>
CC: bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org
Subject: Re: select() efficiency / epoll
References: <42E162B6.2000602@davyandbeth.com>	 <20050722212454.GB18988@outpost.ds9a.nl>	 <430AF11A.5000303@davyandbeth.com>	 <b3f2685905082312301868f00e@mail.gmail.com>	 <430B0E28.5090403@davyandbeth.com> <b3f2685905082313423080e4e4@mail.gmail.com>
In-Reply-To: <b3f2685905082313423080e4e4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Aug 2005 01:09:00.0250 (UTC) FILETIME=[68FDC3A0:01C5A848]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jari Sundell wrote:

>On 8/23/05, Davy Durham <pubaddr2@davyandbeth.com> wrote:
>  
>
>I was hoping you would mention in your reply that you knew
>epoll_data_t was an union and you didn't touch epoll_data::fd, so i
>wouldn't have to say it explicitly. ;)
>
>  
>
No, I saw that epoll_data_t was a union (although, it kind of makes the 
ptr useless as a user data pointer.. but I'm not using it for that)

When I mean that pointers are getting corrupted, I just mean in other 
parts of the code (actually it's some C++ STL container's data and is 
completely unrelated to the epoll specific code)  Something, somewhere 
seems to be writing to memory that it's not supposed to be writing to.  
And as far as I can tell, it happens when I use epoll and doesn't when I 
use select  :-/

-- Davy





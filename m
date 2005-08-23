Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbVHXBif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbVHXBif (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 21:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbVHXBif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 21:38:35 -0400
Received: from intranet.networkstreaming.com ([24.227.179.66]:6589 "EHLO
	networkstreaming.com") by vger.kernel.org with ESMTP
	id S1751341AbVHXBie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 21:38:34 -0400
Message-ID: <430B5F7C.1060309@davyandbeth.com>
Date: Tue, 23 Aug 2005 12:40:12 -0500
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
X-OriginalArrivalTime: 24 Aug 2005 01:38:10.0218 (UTC) FILETIME=[7C0DB0A0:01C5A84C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jari Sundell wrote:

>On 8/23/05, Davy Durham <pubaddr2@davyandbeth.com> wrote:
>
>  
>
>I was hoping you would mention in your reply that you knew
>epoll_data_t was an union and you didn't touch epoll_data::fd, so i
>wouldn't have to say it explicitly. ;)
>
>  
>
Oh!.. unless the epoll_data_t is a union just for convenience in that it 
already has an 'int fd' if you want to use that, but don't have to.. 
that at least makes the void *ptr, useful..  The example in 'man epoll' 
sorta made it look necessary to set the 'fd' of the union.

But that still doesn't fix the issue of course.. but good to know.

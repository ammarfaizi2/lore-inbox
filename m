Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbTIYN5l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 09:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbTIYN5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 09:57:41 -0400
Received: from phobos.aros.net ([66.219.192.20]:37650 "EHLO phobos.aros.net")
	by vger.kernel.org with ESMTP id S261185AbTIYN5k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 09:57:40 -0400
Message-ID: <3F72F44C.1010109@aros.net>
Date: Thu, 25 Sep 2003 07:57:32 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Norris, Brent" <bnorris@Edmonson.k12.ky.us>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: 128G Limit in Reiserfs? Or the Kernel? Or something else?
References: <9A8F8D67DC8ED311BF3E0008C7B9A0ADBAA86E@E151000N0>
In-Reply-To: <9A8F8D67DC8ED311BF3E0008C7B9A0ADBAA86E@E151000N0>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norris, Brent wrote:

>I seem to have hit an odd limit, that I didn't think existed.  I have a 250G
>WD IDE hard drive that I have just installed.  Since I couldn't put a Ext3
>filesystem on it (mount wouldn't recognize it) I decided to put a ReiserFS
>filesystem on it.  Since I have done that I have added 128G of data to the
>drive.  Now when I attempt to copy more data to it I get an error that there
>is no more space on the drive.
>
>I can touch a 0 byte file and delete it, but as soon as I attempt to move
>anything over there with any size it errors out.  df shows me as having 112G
>free on that drive so I am a little confused as to what is giving me this
>error.  Is it the kernel that is not letting me write to the rest of the
>drive or reiserfs or something completely different?  Any help would be
>welcome.  Thanks.
> 
>
This probably has to do with the 128GB IDE disk boundary problems that 
have been recently coming about and nothing to do with Reiserfs (except 
that Reiserfs gets stuck with it). What version of the linux kernel are 
you using? Ie. provide some more info like what's 'uname -a' say on your 
system. There's been a few patches go by this list to fix this disk size 
problem. They should also be in the latest kernel releases too.


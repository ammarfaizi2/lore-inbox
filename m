Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbVJXDwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbVJXDwD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 23:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbVJXDwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 23:52:03 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:31382 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750957AbVJXDwC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 23:52:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=p0qXPFBsn4lpLcX2wAowgheCCaEvWOe08a4KosWchbcFbPkgKkePLduvc/OSvaGVpv33U3C12iSiWFhIml8pFsNeK92U4gyZIdoaHPeS7sjxe2Qlt0oOZjyqb+3vYw93vnmBJKYiPWTCZ0n1RFzvIzVunsW7Iuo5pq7qRS2Gysk=
Message-ID: <435C5A58.5060404@gmail.com>
Date: Mon, 24 Oct 2005 12:51:52 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] matchreply (deliver mails into folders with associated
 threads)
References: <434C1F23.7020702@gmail.com>
In-Reply-To: <434C1F23.7020702@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> 
>  Hello, all.
> 
>  This isn't really linux kernel related but I wrote this to track LKML 
> discussion threads better and I hope this can make following LKML a 
> little bit easier for others too.
> 
>  What matchreply does is to enable procmail to deliver a message into 
> the folder containing its associated thread.  So, when you find an 
> interesting thread on LKML, just move the thread into your 'interested' 
> folder, and then all follow-up messages will be delievered there.
> 
>  matchreply assumes Maildir format folders and uses inotify, so you need 
> kernel version >= 2.6.13.
> 
>  README (explains how to setup .procmailrc) is at
> 
> http://home-tj.org/matchreply/files/README
> 
>  Source tarball
> 
> http://home-tj.org/matchreply/files/matchreply-0.1.tar.gz
> 
>  Binaries for i386 and x86_64
> 
> http://home-tj.org/matchreply/files/binary-matchreply-0.1-i386
> http://home-tj.org/matchreply/files/binary-matchreply-0.1-x86_64
> 
>  Thanks.
> 

  A bugfix release 0.11 is available.  A buffer overflow bug in 
log_message() is fixed.  What can be overwritten by overflowing the 
buffer is only "\n\0", so it shouldn't be very dangerous.  Still, it's a 
buffer overflow which can be triggered by incoming messages.  Please 
update.  Sorry for the hassle.

http://home-tj.org/wiki/index.php/Matchreply
http://home-tj.org/files/matchreply/matchreply-0.11.tar.gz
http://home-tj.org/files/matchreply/binary-matchreply-0.11-x86_64
http://home-tj.org/files/matchreply/binary-matchreply-0.11-i386

  Thanks.

-- 
tejun

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbWFNGDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbWFNGDb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 02:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWFNGDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 02:03:31 -0400
Received: from wehq.winbond.com.tw ([202.39.229.15]:17383 "EHLO
	wehq.winbond.com.tw") by vger.kernel.org with ESMTP id S932405AbWFNGDa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 02:03:30 -0400
thread-index: AcaPeDRqKOEsSnAST1uFWgHwJ2Pqhg==
Content-Class: urn:content-classes:message
Importance: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.326
Message-ID: <448FA698.201@winbond.com>
Date: Wed, 14 Jun 2006 14:03:04 +0800
From: "dezheng shen" <dzshen@winbond.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "PI14 SJIN" <SJin@winbond.com>
Subject: Re: [Winbond] flash memory reader SCSI device drivers
References: <448E875A.40805@winbond.com> <9a8748490606130258k60cdf429n89b1d1d017af60fe@mail.gmail.com>
In-Reply-To: <9a8748490606130258k60cdf429n89b1d1d017af60fe@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-OriginalArrivalTime: 14 Jun 2006 06:03:04.0224 (UTC) FILETIME=[33110A00:01C68F78]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> Please review the following files before posting the patches :
>
>  Documentation/CodingStyle

   right now, we are working on this one. However, I spotted one 
statement in coding style

GLOBAL variables (to be used only if you _really_ need them) need to
have descriptive names, as do global functions.  If you have a function
that counts the number of active users, you should call that
"count_active_users()" or similar, you should _not_ call it "cntusr()".

  we used global variables in our codes to make coding easier. For 
example, we placed some variable on stack so that spaces are 
automatically allocated once our driver is loaded into memory and it is 
also automatically deallocated once our driver is unloaded. Thus, we 
don't have to consider WHAT IF situations in our codes. Of course, we 
can use dynamically allocated kernel memory but it just makes our codes 
a little complex.

  My question is -- could we use global variables if they are NOT 
absolutely necessary?

thank you,

dz




>  Documentation/SubmittingDrivers
>  Documentation/SubmittingPatches
>
> and make sure you've cleaned up the code to follow CodingStyle -
> otherwise that's just going to be the first thing people will tell you
> to fix :-)
>
> Also make sure you include appropriate "Signed-off-by:" lines on the
> patches and please post patches inline, not as attachments (and please
> test send those mails to yourself first and check that the patches
> apply and have not been mangled by your email client).
>
>
>>  This is the first we send this request to this mailing list and we are
>> not sure this is the right way to do. If any of you is interested in
>> reviewing our sources for Memory Stick driver for Winbond w518 chip,
>> please let me know so that we can post our sources.
>>
> I don't have the appropriate hardware, but I'd still be interrested in
> taking a look at the patches, and I'm sure many other people feel the
> same way.
> I'd say posting the patches on LKML and adding relevant people/lists
> from the MAINTAINERS file to Cc would be the way to do it.
>
>



===========================================================================================
The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbTF2U2y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 16:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265084AbTF2U0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 16:26:52 -0400
Received: from smtp-out.comcast.net ([24.153.64.109]:7459 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S264979AbTF2U0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 16:26:04 -0400
Date: Sun, 29 Jun 2003 16:38:55 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: File System conversion -- ideas
In-reply-to: <Pine.LNX.4.55.0306291317300.14949@bigblue.dev.mcafeelabs.com>
To: Davide Libenzi <davidel@xmailserver.org>, linux-kernel@vger.kernel.org
Message-id: <200306291638550960.02442800@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk>
 <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEF8F.7050607@post.pl>
 <20030629192847.GB26258@mail.jlokier.co.uk>
 <20030629194215.GG27348@parcelfarce.linux.theplanet.co.uk>
 <200306291545410600.02136814@smtp.comcast.net>
 <20030629200020.GH27348@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.55.0306291317300.14949@bigblue.dev.mcafeelabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



*********** REPLY SEPARATOR  ***********

On 6/29/2003 at 1:19 PM Davide Libenzi wrote:

>On Sun, 29 Jun 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
>
>> I think that I will believe it when I see the patchset implementing it.
>> Provided that it will be convincing enough.  Other than that...  Not
>> really.  You will need code for each pair of filesystems, since
>> convertor will need to know *both* layouts.  No amount of handwaving
>> is likely to work around that.  And we have what, something between
>> 10 and 20 local filesystems?  Have fun...
>>
>> If you want your idea to be considered seriously - take reiserfs code,
>> take ext3 code, copy both to userland and put together a conversion
>> between them.  Both ways.  That, by definition, is easier than doing
>> it in kernel - you have the same code available and none of the
>limitations/
>> interaction with other stuff.  When you have it working, well, time to
>> see what extra PITA will come from making it coexist with other parts
>> of kernel (and with much more poor runtime environment).
>>
>> AFAICS, it is _very_ hard to implement.  Even outside of the kernel.
>> If you can get it done - well, that might do a lot for having the
>> idea considered seriously.  "Might" since you need to do it in a way
>> that would survive transplantation into the kernel _and_ would scale
>> better that O((number of filesystem types)^2).
>
>Maybe defining a "neutral" metadata export/import might help in limiting
>such NFS^2 ...
>
>

That was in the original message.  :-p  Some people don't read.

>
>- Davide
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

--Bluefox Icy



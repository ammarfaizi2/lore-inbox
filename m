Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264441AbTLPD4A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 22:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264452AbTLPDz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 22:55:59 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:61713 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S264441AbTLPDz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 22:55:57 -0500
Message-ID: <3FDE8258.4050801@nishanet.com>
Date: Mon, 15 Dec 2003 22:56:08 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: IRQ disabled (SATA) on NForce2 and my theory
References: <frodoid.frodo.87wu8zzgly.fsf@usenet.frodoid.org> <3FDD4F7C.7090303@nishanet.com> <200312151555.51845.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200312151555.51845.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>On Monday 15 of December 2003 07:06, Bob wrote:
>  
>
>>sii chips have a long history of needing to
>>hdparm off the unmask interrupt feature.
>>
>>I don't know about that chip but for
>>sii680 there is a special option "-p9"
>>for hdparm which is to say pio mode 9
>>is a special instruction in addition to
>>standard hdparm opt "-u0" turning off
>>irq unmask.
>>    
>>
>
>There is no such thing as 'special option "-p9"' for sii680.
>  
>
Passing PIO mode 9 to sii680 will make it do udma133 with
unmask off, same as "-X70 -u0". What sii did was to make a
bug a feature by embedding their own special pio mode for the
well-known cmdxxx unmask off requirement.

Making A Bug A Feature is begging for "deprecation".

Since -p9 was only documented to set u133 and unmask off,
making a bug a feature, non-bug features are not user-expected
to be set without using other(normal) hdparm options, so
somebody might as well "man hdparm" and bypass the silly
kludge which probably was an internal office joke anyway.

-Bob

>>/sbin/hdparm -d1 -c1 -p9 -X70 -u0 -k0 -i $a
>>    
>>
>
>-X70 is only valid if your device is UDMA133.
>
>--bart
>
>  
>


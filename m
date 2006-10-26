Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945995AbWJZXfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945995AbWJZXfi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 19:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945996AbWJZXfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 19:35:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:5688 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1945995AbWJZXfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 19:35:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=ekfH0M07jxG6F5ue491bhMvHHuQfnD6HI5advnYBp1oXMj+6dwEnUtOvHPgl1ytQdyVpxMqBKfFHrOipTe8oG3jbyaw14rfoDy+fnU8Bdj/FqHQF0MpTzBfgA6n38ba2TZ7wyaOjoN/W4XfFj3k6qVbNKXURQPwigyE78iBxDIU=
Message-ID: <45414641.6060709@gmail.com>
Date: Fri, 27 Oct 2006 01:35:06 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Adrian Bunk <bunk@stusta.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: removing drivers and ISA support? [Was: Char: correct pci_get_device
 changes]
References: <4540F79C.7070705@gmail.com> <20061026222525.GP27968@stusta.de> <9a8748490610261531s539b0861t621e95c785b53d7@mail.gmail.com>
In-Reply-To: <9a8748490610261531s539b0861t621e95c785b53d7@mail.gmail.com>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On 27/10/06, Adrian Bunk <bunk@stusta.de> wrote:
>> On Thu, Oct 26, 2006 at 07:59:56PM +0200, Jiri Slaby wrote:
>> >...
>> > And what about (E)ISA support. When converting to pci probing,
>> should be ISA bus
>> > support preserved (how much is ISA used in present)? -- it makes
>> code ugly and long.
>>
>> There seem to be still many running 486 machines - and only the last 486
>> boards also had PCI slots.
>>
>> While deprecating OSS drivers, I got emails from people still using some
>> of the ISA cards.

That might be a problem if the whole subsystem disappears, but if only ISA
support from some driver is pruned away, they are still able to use the old
driver by replacing the new one from some older kernel.
Then, we'll get nicer drivers in return.

>> And there are even Pentium 4 boards with ISA slots available.
>>
> Not to mention many embedded boards - many pc104 boards use ISA, just
> to mention one type.

I don't know if you understand me correctly (I might write it slightly unclear)
and if I understand you correctly now. I didn't mean to wipe out the (E)ISA
support from the kernel, I meant eliminating it from drivers which will be
rewritten to pci probing.

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E

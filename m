Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292507AbSBZALh>; Mon, 25 Feb 2002 19:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292523AbSBZAL2>; Mon, 25 Feb 2002 19:11:28 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:46604 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S292507AbSBZALU>; Mon, 25 Feb 2002 19:11:20 -0500
Path: Home.Lunix!not-for-mail
Subject: Re: setsockopt(SOL_SOCKET, SO_SNDBUF) broken on 2.4.18?
Date: Tue, 26 Feb 2002 00:11:30 +0000 (UTC)
Organization: lunix confusion services
In-Reply-To: <E16_Tly-0006Va-00@the-village.bc.nu>
NNTP-Posting-Host: kali.eth
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: quasar.home.lunix 1014682290 635 10.253.0.3 (26 Feb 2002 00:11:30
    GMT)
X-Complaints-To: abuse-0@ton.iguana.be
NNTP-Posting-Date: Tue, 26 Feb 2002 00:11:30 +0000 (UTC)
X-Newsreader: knews 1.0b.0
Xref: Home.Lunix mail.linux.kernel:137302
X-Mailer: Perl5 Mail::Internet v1.33
Message-Id: <a5ejri$jr$1@post.home.lunix>
From: linux-kernel@ton.iguana.be (Ton Hospel)
To: linux-kernel@vger.kernel.org
Reply-To: linux-kernel@ton.iguana.be (Ton Hospel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E16_Tly-0006Va-00@the-village.bc.nu>,
	Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
>> to verify what the kernel has set, I read TWICE as much the amount used
>> for the set.  That is, if I set 8192, I read 16384.  Therefore, to set
>> the correct size, I need to half the parameter first.
>> Is this a known bug?  Is it setsockopt or getsockopt which returns the
>> wrong size?
> 
> Neither. You asked for 8K the kernel allows a bit more for BSD compatibility
> and other things. You query and it gives back the size it chose

it's still insane it doesn't use the same fudge factor in both directions.

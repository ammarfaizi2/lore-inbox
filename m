Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263123AbRFECcy>; Mon, 4 Jun 2001 22:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263130AbRFECco>; Mon, 4 Jun 2001 22:32:44 -0400
Received: from smtp8.xs4all.nl ([194.109.127.134]:36048 "EHLO smtp8.xs4all.nl")
	by vger.kernel.org with ESMTP id <S263123AbRFECc3>;
	Mon, 4 Jun 2001 22:32:29 -0400
Path: Home.Lunix!not-for-mail
Subject: Re: symlink_prefix
Date: Tue, 5 Jun 2001 02:31:56 +0000 (UTC)
Organization: lunix confusion services
In-Reply-To: <200106041228.IAA08746@mailer.progressive-comp.com>
NNTP-Posting-Host: kali.eth
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: quasar.home.lunix 991708316 6971 10.253.0.3 (5 Jun 2001 02:31:56 GMT)
X-Complaints-To: abuse-0@ton.iguana.be
NNTP-Posting-Date: Tue, 5 Jun 2001 02:31:56 +0000 (UTC)
X-Newsreader: knews 1.0b.0
Xref: Home.Lunix mail.linux.kernel:94655
X-Mailer: Perl5 Mail::Internet v1.33
Message-Id: <9fhgas$6pr$1@post.home.lunix>
From: linux-kernel@ton.iguana.be (Ton Hospel)
To: linux-kernel@vger.kernel.org
Reply-To: linux-kernel@ton.iguana.be (Ton Hospel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200106041228.IAA08746@mailer.progressive-comp.com>,
	Hank Leininger <linux-kernel@progressive-comp.com> writes:
> On 2001-06-03, Andries.Brouwer@cwi.nl wrote:
> 
>> Suppose I have devices /dev/a, /dev/b, /dev/c that contain the
>> /, /usr and /usr/spool filesystems for FOO OS. Now
>>         mount /dev/a /mnt -o symlink_prefix=/mnt
>>         mount /dev/b /mnt/usr -o symlink_prefix=/mnt
>>         mount /dev/c /mnt/usr/spool -o symlink_prefix=/mnt
> 
> Cool.
> 
> What happens when someone creates new absolute symlinks under /mnt ?
> Will/should the magic /mnt/ header be stripped from any symlink created
> under such a path-translated volume?  The answer is probably 'yes', but
> either one violates POLA :(
> 
I think the semantics should be these that are used in the old usespace
nfsd for the "link_relative" option. That one had very intuitive semantics
and behaved sanely even if you had insane recursive machine crossmounts

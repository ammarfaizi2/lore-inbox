Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbQLaDsf>; Sat, 30 Dec 2000 22:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130643AbQLaDs0>; Sat, 30 Dec 2000 22:48:26 -0500
Received: from smtp8.xs4all.nl ([194.109.127.134]:58842 "EHLO smtp8.xs4all.nl")
	by vger.kernel.org with ESMTP id <S129436AbQLaDsK>;
	Sat, 30 Dec 2000 22:48:10 -0500
Path: Home.Lunix!not-for-mail
Subject: Re: PROBLEM: multiple mount of devices possible 2.4.0-test1 -
    2.4.0-test13-pre4
Date: Sun, 31 Dec 2000 03:18:21 +0000 (UTC)
Organization: lunix confusion services
In-Reply-To: <Pine.GSO.4.21.0012301829190.4082-100000@weyl.math.psu.edu>
NNTP-Posting-Host: kali.eth
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Trace: quasar.home.lunix 978232701 30725 10.253.0.3 (31 Dec 2000
    03:18:21 GMT)
X-Complaints-To: abuse-0@ton.iguana.be
NNTP-Posting-Date: Sun, 31 Dec 2000 03:18:21 +0000 (UTC)
X-Newsreader: knews 1.0b.0
Xref: Home.Lunix mail.linux.kernel:66223
X-Mailer: Perl5 Mail::Internet v1.32
Message-Id: <92m8ht$u05$1@post.home.lunix>
From: linux-kernel@ton.iguana.be (Ton Hospel)
To: linux-kernel@vger.kernel.org
Reply-To: linux-kernel@ton.iguana.be (Ton Hospel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.GSO.4.21.0012301829190.4082-100000@weyl.math.psu.edu>,
	Alexander Viro <viro@math.psu.edu> writes:
> On Sat, 30 Dec 2000, Ton Hospel wrote:
> 
>> It should still need a special flag or something, since it's
>> impossible for userspace to check this atomically.
> 
> To check _what_? Having the same tree mounted in several places is
> allowed. End of story. Atomicity of any kind is a non-issue - if you
> have processes that do not cooperate and do random mounts you are
> getting exactly what you are asking for.
> 

I wasn't talking about mounting the same device on different mount points.
If you ask for that, it's good that you nowadays you can get that (though
even there it might be a good idea to let the filesystem say if it can
support that or not)

I was talking about avoiding that the same device gets multiple mounted 
at the SAME place, e.g. when doing mount -a, which is often used as a
quick way to get the new entries in /etc/fstab

That would also be no problem if there were a standard about e.g. always
flocking /etc/mtab. But as far as I know there isn't such a standard.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

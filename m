Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266765AbTAOThp>; Wed, 15 Jan 2003 14:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266907AbTAOThp>; Wed, 15 Jan 2003 14:37:45 -0500
Received: from ncc1701.cistron.net ([62.216.30.38]:18450 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S266765AbTAOThn>; Wed, 15 Jan 2003 14:37:43 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: argv0 revisited...
Date: Wed, 15 Jan 2003 19:46:38 +0000 (UTC)
Organization: Cistron
Message-ID: <b04dqu$4f5$1@ncc1701.cistron.net>
References: <A46BBDB345A7D5118EC90002A5072C7806CACA88@orsmsx116.jf.intel.com> <20030115191942.GD47@DervishD>
Content-Type: text/plain; charset=iso-8859-15
X-Trace: ncc1701.cistron.net 1042659998 4581 62.216.29.67 (15 Jan 2003 19:46:38 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030115191942.GD47@DervishD>,
DervishD  <raul@pleyades.net> wrote:
>> > of init. Remember, is not any program, is an init. Should be a more
>> > clean way, I suppose :??
>> I don't think is that big a deal ... if you startup the system normally,
>> sooner or later, /proc is going to be mounted. A [quickie] variation is:
>
>    Yes, I know, and that's one option, but I would like to avoid the
>mounting. Not a big deal, anyway, as you say. The only thing is that
>it won't work in kernels without proc enabled (yes, there are people
>without 'proc', size issues, I suppose, etc...).

I assume that init is passed on the kernel command line like
init=/what/ever, right ?

Why not make that INIT=/what/ever, then make this /sbin/init:

main()
{
	execl(getenv("INIT"), getenv("INIT"), "other", "args", NULL);
}

Kernel command line args not reckognized by the kernel get put
into the environment of init ..

Mike.
-- 
They all laughed when I said I wanted to build a joke-telling machine.
Well, I showed them! Nobody's laughing *now*! -- acesteves@clix.pt


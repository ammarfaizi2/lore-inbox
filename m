Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292926AbSBVQn1>; Fri, 22 Feb 2002 11:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292925AbSBVQnQ>; Fri, 22 Feb 2002 11:43:16 -0500
Received: from ncc1701.cistron.net ([195.64.68.38]:5898 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S292655AbSBVQnG>; Fri, 22 Feb 2002 11:43:06 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: Problem? 802.1q kernel 2.4.18-rc1-rmap12f
Date: Fri, 22 Feb 2002 16:43:02 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <a55sem$425$2@ncc1701.cistron.net>
In-Reply-To: <Pine.LNX.4.31.0202221815590.28962-100000@linux.kappa.ro>
Content-Type: text/plain; charset=iso8859-15
X-Trace: ncc1701.cistron.net 1014396182 4165 195.64.65.67 (22 Feb 2002 16:43:02 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.31.0202221815590.28962-100000@linux.kappa.ro>,
Teodor Iacob  <Teodor.Iacob@astral.kappa.ro> wrote:
>I want to use the eth0 as 2 subinterfaces with 802.1q with vlan IDs 3 and
>5, so this is how I set the whole thing up:
>
>/sbin/ifconfig eth0 up # This to make the link of the interface up
>vconfig add eth0 5
>vconfig add eth0 3
>
>/sbin/ifconfig eth0.5 inet ..etc..
>/sbin/ifconfig eth0.3 inet ...etc..
>
>and I have also the default gateway through the eth0.5 vlan.
>
>Now after a fresh start, I can ping whatever I want, but I cannot start a
>file transfer, it just locks up after first 1024 bytes ( as seen with tick
>in simple ftp command ).

Did you patch the ethernet driver so that it supports the bigger
MTUs needed for VLAN support ? It's all described in the VLAN patch docs.

Mike.
-- 
Computers are useless, they only give answers. --Pablo Picasso


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282967AbSAFWiK>; Sun, 6 Jan 2002 17:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287573AbSAFWiA>; Sun, 6 Jan 2002 17:38:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52228 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S282967AbSAFWhn>;
	Sun, 6 Jan 2002 17:37:43 -0500
Message-ID: <3C38D1B3.51724D66@mandrakesoft.com>
Date: Sun, 06 Jan 2002 17:37:39 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] Unbork fs.h, 1 of 4
In-Reply-To: <E16NLbK-0001LE-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I share the opinion of a couple others, to use generic_ip and
generic_sbp.  That's what they are there for.

May I suggest the course of action whereby you convert the code to use
ext2_sb(sb) and ext2_i(inode) first, without changing fs.h at all.  That
lays the groundwork for arguing out the final solution, and the code is
much cleaner either way.

I have not seen anyone arguing -against- ext2_sb() and ext2_i()
cleanups... they seem to make the code obviously more clean.

After those cleanups go in, your further "unbork fs.h" patches will be
smaller and only show the core changes you are interested in.

	Jeff



-- 
Jeff Garzik      | Alternate titles for LOTR:
Building 1024    | Fast Times at Uruk-Hai
MandrakeSoft     | The Took, the Elf, His Daughter and Her Lover
                 | Samwise Gamgee: International Hobbit of Mystery

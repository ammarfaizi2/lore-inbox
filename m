Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289571AbSBONwH>; Fri, 15 Feb 2002 08:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289735AbSBONv5>; Fri, 15 Feb 2002 08:51:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65029 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289571AbSBONvn>;
	Fri, 15 Feb 2002 08:51:43 -0500
Message-ID: <3C6D126B.E5B4810A@mandrakesoft.com>
Date: Fri, 15 Feb 2002 08:51:39 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, davidm@hpl.hp.com,
        "David S. Miller" <davem@redhat.com>, anton@samba.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] move task_struct allocation to arch
In-Reply-To: <Pine.LNX.4.33.0202151439160.1001-100000@serv>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> 
> Hi,
> 
> On Fri, 15 Feb 2002, David Howells wrote:
> 
> > Firstly, in response to me having supplied a patch that made a set of four
> > byte-size values as the status area in the task_struct:
> >
> > | For the future, the biggest thing I'd like to see is actually to make
> > | "work" be a bitmap, because the "bytes are atomic" approach simply isn't
> > | portable anyway, so we might as well make things _explicitly_ atomic and
> > | use bit operations. Otherwise the alpha version of "work" would have to be
> > | four bytes per "bit" of information, which sounds really excessive.
> 
> As I mentioned before I more like the byte approach, since atomic bit
> field handling is quite expensive on most architectures, where a simple
> set/clear byte is only one or two instructions, if there is byte
> load/store instruction. So I'd really like to see to leave the decision to
> the architecture, whether to use bit or byte fields.

We have tons of code already using atomic test_and_set_bit type
stuff...  why not just make sure your bit set/clear stuff is fast?  :)

	Jeff


-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com

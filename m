Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287658AbSBIVkG>; Sat, 9 Feb 2002 16:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287684AbSBIVj4>; Sat, 9 Feb 2002 16:39:56 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:35531 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S287658AbSBIVjq>;
	Sat, 9 Feb 2002 16:39:46 -0500
Date: Sat, 09 Feb 2002 21:39:39 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Mike Touloumtzis <miket@bluemug.com>,
        Daniel Phillips <phillips@bonn-fries.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
Message-ID: <2349726337.1013290778@[195.224.237.69]>
In-Reply-To: <20020207203451.GE26826@bluemug.com>
In-Reply-To: <20020207203451.GE26826@bluemug.com>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Thursday, 07 February, 2002 12:34 PM -0800 Mike Touloumtzis 
<miket@bluemug.com> wrote:

> I'm talking about rsync now, not cat (that was reductio ad absurdum to
> make a point).  In case you haven't compiled any userspace programs in
> a while: many of them have configuration options.  In the case of rsync,
> things like "--enable-profile" and "--disable-ipv6".

Well, picking a package with a non-trivial config file for compilation,
and picking the one which is most easy to recompile (postfix):

shed:/home/amb# postconf | head
2bounce_notice_recipient = postmaster
access_map_reject_code = 554
alias_database = hash:/etc/aliases
alias_maps = hash:/etc/aliases
allow_mail_to_commands = alias,forward
...
command_directory = /usr/sbin
...


I'd say that's storing it's compilation config (it's in there too)
live - at least sufficient to allow me to rebuild it. And I've used
it.

> A final argument for using packaging/bundling tools and userspace files
> instead of files in /proc for tracking kernel metadata:

Noone is suggesting that it be compulsorary to delete your 'userspace'
(read 'conventional file system') version of .config etc. The argument
is merely that it is worth the few thousand bytes (one page) of
swapoutable stuff kept with the kernel as well to aid debugging,
rebuilding, etc.; for instance, if you've ever done a binary chop
for 'which config livelocks my kernel on load', this means
typing cp/mv rather fewer times. If you've ever misplaced/mismatched
your .config/kysms, whatever, this will help immeasurably. If you
are booting in an environment where it's easier to move a single
file about (think tftp boot in a network environment for example),
you get the config on there for free. Each of these I have used.

--
Alex Bligh

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288040AbSABX65>; Wed, 2 Jan 2002 18:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288031AbSABX6A>; Wed, 2 Jan 2002 18:58:00 -0500
Received: from marine.sonic.net ([208.201.224.37]:44072 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S287169AbSABX4I>;
	Wed, 2 Jan 2002 18:56:08 -0500
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Wed, 2 Jan 2002 15:56:01 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: "Eric S. Raymond" <esr@thyrsus.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Dave Jones <davej@suse.de>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020102235600.GA28621@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@suse.de>
In-Reply-To: <20020102173419.A21165@thyrsus.com> <E16LuW5-0005w3-00@the-village.bc.nu> <20020102180926.B21788@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020102180926.B21788@thyrsus.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 06:09:26PM -0500, Eric S. Raymond wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > Of course it isnt. cat /proc/dmi executes kernel mode code which is totally
> > priviledged. /sbin/dmidecode executes slightly priviledged code which will

I hope you at least recomment /usr/sbin/dmidecode.  Least I hope that isn't
necessary for booting.  ;->

> > core dump not crash the box if it misparses the mapped table.
> 
> You're thinking inside-out again.  Sigh...user privileges. *User* privileges! 

It's not just a simple od -c type of output that a post-processor could
decode turn back into binary and decode.  The routine would still have to
locate the DMI table, and decode at least the appropriate length of the
table, present that to the output, and then dump the output in hex format
or something.  Why risk getting that wrong and screwing up kernel internals
when it can already be done in userspace?

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc

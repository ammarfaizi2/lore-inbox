Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265242AbTB0R0u>; Thu, 27 Feb 2003 12:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265680AbTB0R0u>; Thu, 27 Feb 2003 12:26:50 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:51473 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S265242AbTB0R0u>; Thu, 27 Feb 2003 12:26:50 -0500
Date: Thu, 27 Feb 2003 17:37:04 +0000
From: John Levon <levon@movementarian.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: oprofile-list@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Oops running oprofile in 2.5.62
Message-ID: <20030227173704.GA76419@compsoc.man.ac.uk>
References: <3E5DB057.60503@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E5DB057.60503@us.ibm.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18oRxx-0004DC-00*UsALvuAFBKA*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2003 at 10:29:43PM -0800, Dave Hansen wrote:

> I'm pretty sure it happened on this line in oprofile_add_sample():
> 	cpu_buf->buffer[cpu_buf->pos].eip = eip;
> 
> Unable to handle kernel paging request at virtual address f8c3c000

Odd. UP or SMP ? Were you shutting down oprofile at the time (or did the
daemon crash ? check /var/lib/oprofile/oprofiled.log)

The only thing I can think is that the buffer got freed then we  got an
NMI afterwards (which obviously isn't supposed to happen...)

UP oprofile in current linus is still totally broken, but I can't
imagine it causing the above.

regards
john

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262715AbVAVNgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262715AbVAVNgm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 08:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262716AbVAVNgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 08:36:42 -0500
Received: from mailgate.pit.comms.marconi.com ([169.144.68.6]:52985 "EHLO
	mailgate.pit.comms.marconi.com") by vger.kernel.org with ESMTP
	id S262715AbVAVNgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 08:36:38 -0500
Message-ID: <313680C9A886D511A06000204840E1CF0A647550@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: saving & follow-up analyzing (by the bootloader) the  kernel boo
	t log buffer on "vanilla"Linux (2.6)  usable for all architecture platfor
	ms
Date: Sat, 22 Jan 2005 08:35:34 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could such examination be made available (as a debug option)
in the simple bootloader's load_kernel(),
before "unzipping" kernel ?

I presume that the code for outputting log buffer,
currently executed during the kernel booting (after console_init()),
could be placed in the library
and thus be available for simple boot loader ?

That would require adding some sort of testable bit pattern
being stored at the header and tail of the log_buf,
so it could be checked for corruption upon reading 
(may be checksum too ?)

Who among Linux kernel maintainers would be interested in doing so ?

PS 
-----Original Message-----
From: Tom Rini [mailto:trini@kernel.crashing.org]
Sent: Friday, January 21, 2005 6:49 PM
To: Povolotsky, Alexander
Subject: Re: where in the (simple ?) bootloader I could examine the
preser ved (in the memory) content of the log buffer


On Fri, Jan 21, 2005 at 05:39:19PM -0500, Povolotsky, Alexander wrote:

> But the issue at question is to pass saved (in memory) content of the
> log_buf, filled by unsuccessful kernel boot,
> via soft reboot to the bootloader for follow-up examination ...

I suppose so long as the firmware doesn't erase or otherwise overwrite
things, you should be able to find log_buf by looking at System.map and
subtracing 0xc0000000.

-- 
Tom Rini
http://gate.crashing.org/~trini/


>  -----Original Message-----
> From: 	Povolotsky, Alexander  
> Sent:	Saturday, January 22, 2005 6:27 AM
> To:	'Linas Vepstas'
> Cc:	'Andi Kleen (E-mail)'; 'Anton Blanchard (E-mail)'; 'Randy Dunlap
> (E-mail)'; 'Andrew Morton (E-mail)'; 'Alan Cox (E-mail)'; 'Keith Owens
> (E-mail)'
> Subject:	RE:  saving & analyzing (by the bootloader)   kernel boot
> log buffer on "vanilla"Linux (2.6)  usable for for 8xx ppc 
> 
> I would suggest CONSIDER implementing - it would help for early debugging
> when serial console 
> is not working and no "live"output is available - I am in such situation
> right now !
> 
> -----Original Message-----
> From: Olaf Hering [mailto:olh@suse.de]
> Sent: Saturday, January 22, 2005 4:16 AM
> To: Povolotsky, Alexander
> Subject: Re: saving & analyzing (by the bootloader) kernel boot logbuffer
> on "vanilla"Linux (2.6) usable for for 8xx ppc
> 
>  On Sat, Jan 22, Povolotsky, Alexander wrote:
> 
> > > Hi,
> > > 
> > > Is there a project for Linux for creating the functionality to move
> > > the log_buf content into some designated (by the address) memory
> > > buffer during the kernel boot as well as functionality
> > > (to be included into "any" bootloader) for examining
> > > (after the soft reboot ) saved into the memory content of the log_buf
> > >  (filled by the unsuccessful kernel boot) ?
> 
> I dont think there is such functionality. pseries save the panic string
> into some RTAS buffer, but thats all.
> 
> 
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287552AbSAEGrT>; Sat, 5 Jan 2002 01:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287555AbSAEGrJ>; Sat, 5 Jan 2002 01:47:09 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:24328 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S287552AbSAEGrE>;
	Sat, 5 Jan 2002 01:47:04 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15414.41241.254273.63930@argo.ozlabs.ibm.com>
Date: Sat, 5 Jan 2002 17:45:45 +1100 (EST)
To: Lars Brinkhoff <lars.spam@nocrew.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <857kqy4f5p.fsf@junk.nocrew.org>
In-Reply-To: <17B78BDF120BD411B70100500422FC6309E3F8@IIS000>
	<15412.14140.652362.747279@argo.ozlabs.ibm.com>
	<854rm363x5.fsf@junk.nocrew.org>
	<15412.61172.824543.547728@argo.ozlabs.ibm.com>
	<857kqy4f5p.fsf@junk.nocrew.org>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Brinkhoff writes:

> This is true in the classic PDP-10 architecture, but would it
> really be worthwhile to run Linux in an 18-bit address space?.
> 
> In the extended architecture, an int * is a 30-bit address, and the
> byte offset and size is encoded in the top 6 bits.  This would be a
> more suitable target for Linux.

Wow, I didn't know that there was an extended PDP-10 architecture.
It's 25 years since I did anything on a PDP-10. :)

> When a pointer-to-integer conversion is made (or vice versa), GCC
> could generate code to convert between a PDP-10 hardware pointer and a
> linear byte address.

Would you use 9-bit bytes or 8-bit bytes?  If you use 8-bit bytes then
there will be some bits in a word that aren't part of any byte.  If
you use 9-bit bytes, I'm sure that somewhere in the kernel there will
be some code that will break because it is assuming 8-bit bytes.

> The KI10 has limited support for paging, but I don't remember the
> details.  KL10 most definitely supports full paged virtual memory.

Somehow I'm getting the feeling that your next message is going to say
"actually, we have been running linux on the KL10 for the past 3
years". :)

Regards,
Paul.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266220AbUAVKci (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 05:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266221AbUAVKci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 05:32:38 -0500
Received: from dsl-213-023-011-163.arcor-ip.net ([213.23.11.163]:20667 "EHLO
	fusebox.fsfeurope.org") by vger.kernel.org with ESMTP
	id S266220AbUAVKcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 05:32:32 -0500
To: =?iso-8859-15?q?S=E9rgio_Monteiro_Basto?= <sergiomb@netcabo.pt>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       acpi-devel <acpi-devel@lists.sourceforge.net>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ACPI] Re: PROBLEM: ACPI freezes 2.6.1 on boot
References: <Pine.LNX.4.58.0401211051530.2123@home.osdl.org>
	<m3d69dhukz.fsf@reason.gnu-hamburg>
	<1074721887.3672.12.camel@darkstar.portugal>
	<m34qupdj94.fsf@reason.gnu-hamburg>
	<1074727903.3667.49.camel@darkstar.portugal>
From: "Georg C. F. Greve" <greve@gnu.org>
Organisation: Free Software Foundation Europe - GNU Project
X-PGP-Fingerprint: 2D68 D553 70E5 CCF9 75F4 9CC9 6EF8 AFC2 8657 4ACA
X-PGP-Affinity: will accept encrypted messages for GNU Privacy Guard
X-Home-Page: http://gnuhh.org
X-Accept-Language: en, de
Date: Thu, 22 Jan 2004 11:32:01 +0100
In-Reply-To: <1074727903.3667.49.camel@darkstar.portugal> 
 =?iso-8859-15?q?=28S=E9rgio?= Monteiro Basto's message of "21 Jan 2004 23:31:43 +0000")
Message-ID: <m3oesw9sv2.fsf@reason.gnu-hamburg>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 || On 21 Jan 2004 23:31:43 +0000
 || Sérgio Monteiro Basto <sergiomb@netcabo.pt> wrote: 

 smb> So you are another APIC victim :)

Seems that way. :)


 smb> [...]

 smb> And thinking, can be true ? that, if SCI can't be
 smb> level-triggered (like my laptop and yours), kernel with APIC
 smb> (loapic or smp) options will hang on boot !

But can it really not be level triggered? 

My dmesg output tells me explicitly that it switched to level
triggered successfully when APIC is disabled.

So is that message wrong or is there a problem between APIC/ACPI?

Should we not be able to resolve that problem anytime soon, I would
suggest to add some information about this to the Kernel help for both
ACPI and APIC, like:

"
 CAUTION: 
 On some laptops, enabling both local APIC and ACPI can cause
 problems.  Should your system hang during boot with a message like
  'ACPI: IRQ X was Edge Triggered, setting to Level Triggerd'
 you should disable either local APIC (recommended) or ACPI. 
 See http://bugzilla.kernel.org/show_bug.cgi?id=1774 for details.
"

that could save people a lot of time in the future hunting down that
bug again -- also it should limit the amount of mails sent around on
the topic. :)

Regards,
Georg

-- 
Georg C. F. Greve                                       <greve@gnu.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)

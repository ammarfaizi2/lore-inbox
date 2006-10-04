Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161020AbWJDFk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161020AbWJDFk7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 01:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161076AbWJDFk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 01:40:59 -0400
Received: from smtpout.mac.com ([17.250.248.181]:35835 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1161020AbWJDFk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 01:40:58 -0400
In-Reply-To: <18d709710610032108w52d69b17mfa585e40ad2ae72c@mail.gmail.com>
References: <18d709710610032108w52d69b17mfa585e40ad2ae72c@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1E56E1B6-9C2C-4D84-94D6-42B5A87B5739@mac.com>
Cc: Chase Venters <chase.venters@clientec.com>, goodfellas@shellcode.com.ar,
       Linux kernel <linux-kernel@vger.kernel.org>,
       endrazine <endrazine@gmail.com>,
       Stephen Hemminger <shemminger@osdl.org>, Valdis.Kletnieks@vt.edu,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Registration Weakness in Linux Kernel's Binary formats
Date: Wed, 4 Oct 2006 01:40:08 -0400
To: Julio Auto <mindvortex@gmail.com>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 04, 2006, at 00:08:57, Julio Auto wrote:
> I sincerely think you're all missing the point here.

No, _you're_ missing the point.

> The observation is in fact something that can be used by rootkit  
> writers or developers of other forms of malware.

This attack relies on being able to load an arbitrary attacker- 
defined kernel module.  Full Stop.  If you can load code into  
privileged mode it's game over regardless of what other designs and  
restrictions are in place.  The "default" security model is that only  
root can load kernel code, but using SELinux or other methods it's  
possible to entirely prevent anything from being loaded after system  
boot or written to the kernel or bootloader images.

If the attacker gains kernel code access, it doesn't matter what  
"simply linked list" or whatever other garbage is being used, they  
can just overwrite the existing ELF loader with their shellcode if  
they want.  Or they could insert a filesystem patch which always  
loads a virus into any ELF binary at load.  Or they could just fork a  
kernel thread and run their shellcode there.  Or they could load a  
copy of Windows from the CD drive and boot into that from Linux.

Kernel-level access implies ultimate trust and security, and  
*nothing* is going to change that.

Cheers,
Kyle Moffett


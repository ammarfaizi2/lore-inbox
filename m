Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315832AbSEEIE5>; Sun, 5 May 2002 04:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315833AbSEEIE4>; Sun, 5 May 2002 04:04:56 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:2053 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S315832AbSEEIE4>;
	Sun, 5 May 2002 04:04:56 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre8aa2 
In-Reply-To: Your message of "Sun, 05 May 2002 17:40:56 +1000."
             <3CD4E208.181AE989@eyal.emu.id.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 05 May 2002 18:04:41 +1000
Message-ID: <4003.1020585881@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 May 2002 17:40:56 +1000, 
Eyal Lebedinsky <eyal@eyal.emu.id.au> wrote:
>You are right, it is not the unresolved that caused it but the non
>ELF objects in there (it used not to care before):
>
># /sbin/depmod-2.4.15 -ae ; echo $?
>depmod: /lib/modules/2.4.19-pre8-aa2/ksyms is not an ELF file
>depmod: /lib/modules/2.4.19-pre8-aa2/soundconf is not an ELF file
>1

All versions of depmod for 2.4 have always returned errors for invalid
objects in /lib/modules, that check has not changed since modutils
2.4.0.  modutils has not changed, somebody is storing extra text files
in /lib/modules without telling modutils.  Don't do that.

Who created the ksyms and soundconf files?  If they come from some
distribution script, does that distributor ship a modified version of
modutils to ignore the extra files, without telling me?  If so, which
distributor do I have to kill?


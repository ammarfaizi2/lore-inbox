Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262048AbTDAFHA>; Tue, 1 Apr 2003 00:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262052AbTDAFHA>; Tue, 1 Apr 2003 00:07:00 -0500
Received: from daimi.au.dk ([130.225.16.1]:54987 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S262048AbTDAFG7>;
	Tue, 1 Apr 2003 00:06:59 -0500
Message-ID: <3E892117.247A17FE@daimi.au.dk>
Date: Tue, 01 Apr 2003 07:18:15 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-19.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Paul Clements (home)" <pclements@alltel.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: unexporting sys_call_table a good idea?
References: <3E891D8E.9E534400@alltel.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul Clements (home)" wrote:
> 
> Hi all,
> 
> given the recent ptrace-related security bug, it sure would be nice to
> have sys_call_table exported, so that I could just disable ptrace
> altogether on affected systems (where no one is doing any debugging or
> devel work, anyway)... I realize that there are race conditions, etc.,
> with replacing syscalls, but could those not be solved?... as it is,
> rather than being able to simply compile an external module (which
> disables ptrace) and load it on affected systems, I am forced to
> recompile an entire kernel, install it on the affected systems, and
> reboot them all...

You could get the address of sys_call_table from the System.map file
and pass it as an argument to the module.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);

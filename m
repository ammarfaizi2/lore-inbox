Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129910AbRBYXfx>; Sun, 25 Feb 2001 18:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129998AbRBYXfo>; Sun, 25 Feb 2001 18:35:44 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:59191 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S129910AbRBYXfd>;
	Sun, 25 Feb 2001 18:35:33 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Pete Toscano <pete.lkml@toscano.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Mysterious lockups with 2.4.X (Help w/KDB) 
In-Reply-To: Your message of "Sun, 25 Feb 2001 13:39:16 CDT."
             <20010225133916.A1329@bubba.toscano.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 26 Feb 2001 10:33:04 +1100
Message-ID: <10610.983143984@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Feb 2001 13:39:16 -0500, 
Pete Toscano <pete.lkml@toscano.org> wrote:
>Unable to handle kernel NULL pointer dereference at virtual address 0000017c
> printing eip:
>and then the KDB prompt appears.  Back when I had my emu10k problems,
>Keith Owen told me to (in a nutshell), go through the running processes
>and "btp" their PID and look for "text.lock".

Those instructions were for a lockup.  This problem is not a lockup, it
is a bad pointer.  In this case you only care about the current
process.  Backtrace (bt) will show what the process was doing.  'id
%eip' will disassemble the failing code.


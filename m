Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132227AbRCYWSI>; Sun, 25 Mar 2001 17:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132228AbRCYWR6>; Sun, 25 Mar 2001 17:17:58 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:26379 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S132227AbRCYWRm>;
	Sun, 25 Mar 2001 17:17:42 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Nathan Neulinger <nneul@umr.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Non keyboard trigger of Alt-SysRQ-S-U-B 
In-Reply-To: Your message of "Sun, 25 Mar 2001 10:27:28 CST."
             <3ABE1C70.92CBBF01@umr.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 26 Mar 2001 08:16:55 +1000
Message-ID: <6069.985558615@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Mar 2001 10:27:28 -0600, 
Nathan Neulinger <nneul@umr.edu> wrote:
>Is there any way that this can be triggered remotely? I frequently get
>into situations with a particular machine where 'reboot' or 'reboot -f'
>just plain won't work, and would like to be able do a 'filesystem clean'
>forcible reboot, but don't particularly care about services being shut
>down cleanly. Of course, the key is, I'm not at the keyboard of the
>server in question.

If you have a serial console on the server, you can get sysrq by
sending a serial break followed by the character.  See
drivers/char/serial.c on any 2.4 kernel.  Otherwise you could hack up a
module that calls handle_sysrq() directly.  Unless you are sending a
character that needs regs ('p'), kbd ('r') or tty ('k'), you can set
those parameters to NULL.  Any unrecognised character will try to use
kbd and tty parameters.


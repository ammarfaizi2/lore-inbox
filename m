Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135633AbRD1VAh>; Sat, 28 Apr 2001 17:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135632AbRD1VA0>; Sat, 28 Apr 2001 17:00:26 -0400
Received: from tmhoyle.gotadsl.co.uk ([195.149.46.162]:28683 "HELO
	mail.cvsnt.org") by vger.kernel.org with SMTP id <S135631AbRD1VAQ>;
	Sat, 28 Apr 2001 17:00:16 -0400
Subject: RE: just-in-time debugging?
From: Tony Hoyle <tmh@nothing-on.tv>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <XFMail.20010428134448.davidel@xmailserver.org>
Content-Type: text/plain
X-Mailer: Evolution (0.9 - Preview Release)
Date: 28 Apr 2001 22:00:14 +0100
Mime-Version: 1.0
Message-Id: <20010428210013.625F6F6E1@mail.cvsnt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Apr 2001 13:44:48 -0700, Davide Libenzi wrote:
> Sorry but why don't You run Your application with gdb ?
> Once Your program crashes You'll get the prompt and You'll be able to
> stack-trace and watching whatever You need.
> The solution I use to be able to get inside the program even when the gdb is
> not running is the one that You can find in the attached file.
> Basically it install the handler that will create a script file that You can
> use to automatically enter with gdb inside Your program while it's running.



Because the program is invoked as part of a much larger system & I don't

know which process is going to crash when.  

Having gdb come up automatically would greatly decrease development
time.  I'm trying to track down multiple bugs (caused by me, but they
still need tracking down) which show up during stress testing.  The bug
will manifest itself in maybe the 1000th iteration...   If I could hack
gdb into coming up automatically when things went wrong it'd get rid of
the need to have thousands of printf's in the app (which is my primary
debugging tool at the moment).

At work I do this all the time... Windows pops up a dialog which
basically says 'the program has crashed, debug?' and drops you straight
into VC with everything intact.  It has assertion macros which wrap int3
instructions.  You then continue your app under normal debug conditions.

Tony

(Fighting with evolution because Mozilla broke imap again... sigh...)

-- 

"Two weeks before due date, the programmers work 22 hour days cobbling an
 application from... (apparently) one programmer bashing his face into the
 keyboard." -- Dilbert

tmh@magenta-netlogic.com                http://www.nothing-on.tv 


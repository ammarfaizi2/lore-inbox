Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbVIDIqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbVIDIqI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 04:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbVIDIqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 04:46:08 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:26898 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751299AbVIDIqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 04:46:07 -0400
Date: Sun, 4 Sep 2005 10:45:59 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Andreas Hartmann <andihartmann@01019freenet.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: forbid to strace a program
Message-ID: <20050904084559.GC30279@alpha.home.local>
References: <4IOGw-1DU-11@gated-at.bofh.it> <4IOGw-1DU-13@gated-at.bofh.it> <4IOGw-1DU-9@gated-at.bofh.it> <4IOQc-1Pk-23@gated-at.bofh.it> <dfe7ui$14q$1@pD9F874C0.dip0.t-ipconnect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfe7ui$14q$1@pD9F874C0.dip0.t-ipconnect.de>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Sun, Sep 04, 2005 at 09:32:34AM +0200, Andreas Hartmann wrote:
> > Can I ask why you want to hide the database password from root?
> 
> It's easy: for security reasons. There could always be some bugs in some
> software, which makes it possible for some other user, to gain root
> privileges. Now, they could easily strace for information, they shouldn't
> could do it.

Then you're loosing your time. If the user gains root privileges, then he
can do what he wants to get the password, including loading modules or
scanning the memory. For instance, it happened to me several times that
my browser crashed during a post with a very long message. Not funny at
all. Then, as root, I started my hex editor and scaned all memory for
words I was sure I wouldn't find anywhere else, and then I could restore
my data by hand. Doing so to find a password is pretty easy too. And don't
tell me that it's deleted very soon, because it's also possible to send
lots of SIGSTOP/scan/SIGCONT very fast to try to catch the clear password.

> The password they could see, isn't just used for the DB, but
> for some other applications, too. That's the disadvantage of general
> (single sign on) passwords.

can't you use a specific password just for this app ? or use another server
on which no user has access to relay your connections and insert the right
password itself ?

Regards,
Willy


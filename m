Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbUC3Wak (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 17:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbUC3Wak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 17:30:40 -0500
Received: from mail.tpgi.com.au ([203.12.160.100]:15801 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S261425AbUC3Wai
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 17:30:38 -0500
Subject: Re: [Swsusp-devel] [PATCH 2.6]: suspend to disk only available if
	non-modular IDE
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1080631869.1118.12.camel@simulacron>
References: <200403282136.55435.arekm@pld-linux.org>
	 <1080517040.2223.3.camel@laptop-linux.wpcb.org.au>
	 <1080517591.5047.10.camel@laptop-linux.wpcb.org.au>
	 <pan.2004.03.29.21.34.45.973137@dungeon.inka.de>
	 <1080629551.12019.12.camel@laptop-linux.wpcb.org.au>
	 <1080631869.1118.12.camel@simulacron>
Content-Type: text/plain
Message-Id: <1080685396.13014.3.camel@laptop-linux.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk 
Date: Wed, 31 Mar 2004 08:23:16 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2004-03-30 at 17:31, Andreas Jellinghaus wrote:
> > That should be doable, provided that the initrd doesn't mount anything.
> > Decryption is 'interesting'. The key needs to be set up in the resumed
> > kernel too. (Shouldn't be a problem, if you manage to suspend to it!).
> 
> I don't know if loading modules can be done without, but the usual way
> is to mount /sys and /proc so you can see what hardware is available.

They would be fine. The key thing is that none of the filesystems which
have journals get mounted. That would cause the crash recovery routines
to run, resulting inconsistency between the image on disk and the one
that the suspend image contains. You could probably do just about
anything, so long as those filesystems aren't mounted. Assuming that is
done, actually calling suspend after an initrd is run shouldn't be a
problem, so far as I know.

Regards,

Nigel

-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6253 0250 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbWAKT6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbWAKT6U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 14:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbWAKT6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 14:58:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24225 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932478AbWAKT6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 14:58:19 -0500
Date: Wed, 11 Jan 2006 11:57:10 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
Cc: stern@rowland.harvard.edu, linux-kernel@vger.kernel.org, vojtech@suse.cz,
       mailing-lists-mmv@bretschneidernet.de, jengelh@linux01.gwdg.de,
       linux-usb-devel@lists.sourceforge.net, gregkh@suse.de,
       nouser@lpetrov.net, zaitcev@redhat.com
Subject: Re: PROBLEM: PS/2 keyboard does not work with 2.6.15
Message-Id: <20060111115710.42937b7f.zaitcev@redhat.com>
In-Reply-To: <20060111160120.GB8999@sith.mimuw.edu.pl>
References: <20060111000151.GA5712@sith.mimuw.edu.pl>
	<Pine.LNX.4.44L0.0601111024260.5195-100000@iolanthe.rowland.org>
	<20060111160120.GB8999@sith.mimuw.edu.pl>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2006 17:01:20 +0100, Jan Rekorajski <baggins@sith.mimuw.edu.pl> wrote:

> > > This happens on Dell Precision 380, x86_64 kernel with SMP/HT, no options
> > > on kernel command line, same kernel .config (modulo make oldconfig).
> > > I tried all solutions I found on google, none works (beside connecting
> > > USB keyboard or disabling USB in BIOS).
> > 
> > Assuming your BIOS isn't totally out-of-date, what happens if you try 
> > turning off the usb-handoff code and preventing the *hci-hcd.ko drivers 
> > from loading, as described ealier in this thread?
> 
> Wrong assumption, my BIOS was totally out-of-date. After upgrading to
> A04 the problem went away and now everything works fine.

Very good. I suggested this because the PW 380 is a poster child of the
buggy BIOS, and also of industry involvement: Dell fixed the problems
for us. Buy a beer for Matt Domsch.

Here's the original RHEL bug (do not add silly comments or I'll make
it private):
 https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=165749

Notice that the bug deals with broken sharing between EHCI and its
companion controller. This is also something a BIOS breaks often.
But you should've seen wild theories people posted about it to Ubuntu
forums, they just crack me up.

-- Pete

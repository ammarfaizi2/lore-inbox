Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbTDEHge (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 02:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbTDEHge (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 02:36:34 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:30227 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S261924AbTDEHgd (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 02:36:33 -0500
Date: Sat, 5 Apr 2003 09:48:03 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Stephen Cameron <steve.cameron@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to speed up building of modules?
Message-ID: <20030405074803.GA1076@mars.ravnborg.org>
Mail-Followup-To: Stephen Cameron <steve.cameron@hp.com>,
	linux-kernel@vger.kernel.org
References: <20030404085740.GA10052@zuul.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030404085740.GA10052@zuul.cca.cpqcorp.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 02:57:40PM +0600, Stephen Cameron wrote:
> Hi
> 
> I'm wondering if you guys know any tricks to speed up building
> of linux kernel modules.

Have you looked at: LKMB (Linux Kernel Module Builder)
Try google at bit after it. An URL has been posted here a couple of times.

There is also: DKMS: Dynamic Kernel Module Support
Gary Lerhaupt from Dell has mede this and he would be glad for any feedback.

In general I advice you to use:
$ make -C path/to/kernel/src SUBDIRS=$PWD modules
when building modules. That's the _only_ way to make sure you have correct
CFLAGS etc.
This should work for 2. as weel as 2.5.

The Makefile than has to be kbuild conformant, as described in
Documentation/kbuild/makefiles.txt

	Sam

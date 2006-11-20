Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966274AbWKTRlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966274AbWKTRlh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 12:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966272AbWKTRlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 12:41:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12698 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S966274AbWKTRlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 12:41:36 -0500
Date: Mon, 20 Nov 2006 12:41:30 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: multi-function PCI device claiming.
Message-ID: <20061120174130.GA19636@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had a user report a bug against the Fedora kernel where
his Matrox G400 wouldn't work with the matrox framebuffer
driver any more.
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=195825

It turned out to be caused by the fact that the matrox_w1
one-wire driver had loaded first.  Moving that driver
out of the way so that it didn't get loaded would allow
the framebuffer driver to load.

There are a number of similar cases like this which seem
to be coming out of the woodwork lately.  I've also heard
as-yet unconfirmed rumours that agp-intel and one of the
watchdog drivers suffers the same "first to load wins" problem.

What's the correct way to fix this ?

		Dave

-- 
http://www.codemonkey.org.uk

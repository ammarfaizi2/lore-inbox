Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262683AbVAQDvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbVAQDvt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 22:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262682AbVAQDvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 22:51:48 -0500
Received: from gw.goop.org ([64.81.55.164]:47004 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S262683AbVAQDsr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 22:48:47 -0500
Subject: /proc/<pid>/maps API addition - seek to address
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Prasanna Meda <pmeda@akamai.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sun, 16 Jan 2005 19:48:46 -0800
Message-Id: <1105933726.31917.50.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-0.mozer.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would be terribly useful to have some way of
lseeking /proc/<pid>/maps to the entry of a particular address.  So, if
you want to find the information about a mapping containing address
0x12345678, it would set the file position to (say) the entry of
0x12000000-0x20000000.

I haven't looked at how /proc/<pid>/maps is implemented these days; is
this outright hard, or relatively straightforward?  This wouldn't be
very useful if it had to actually generate all the output up to the
desired point, but it would be a boon if it could short-circuit that.  I
guess the interactions with normal lseek might be tricky (but perhaps
that could be put off until you actually use lseek, if ever).

Alternatively, any other API for finding the properties of page X would
be useful, but this seemed like a nice incremental extension of the
existing interface.

	J


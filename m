Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbVKTS1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbVKTS1m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 13:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbVKTS1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 13:27:42 -0500
Received: from host94-205.pool8022.interbusiness.it ([80.22.205.94]:1972 "EHLO
	waobagger.intranet.nucleus.it") by vger.kernel.org with ESMTP
	id S1750792AbVKTS1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 13:27:42 -0500
From: Massimiliano Hofer <max@bbs.cc.uniud.it>
Organization: Nucleus snc
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.14.2 - Hard link count is wrong
Date: Sun, 20 Nov 2005 19:27:42 +0100
User-Agent: KMail/1.9
References: <437E2494.6010005@anagramm.de> <4380914C.1010903@gentoo.org> <200511201614.09858.max@bbs.cc.uniud.it>
In-Reply-To: <200511201614.09858.max@bbs.cc.uniud.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200511201927.43430.max@bbs.cc.uniud.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 November 2005 4:14 pm, Massimiliano Hofer wrote:

> I'll write back as soon as possible with more tests.

I'm back. First of all I beg your pardon for blaming 2.6.14.2, I forgot I 
rebooted with 2.6.13.4.
A cursory check of the mailing list and the changelog doesn't show any obvious 
change in 2.6.14 that would solve this, but I may be overlooking something.

Anyway I couldn't reproduce the bug in 2.6.14.2, but it is easily reproducible 
with 2.6.13.4. Adding and removing a 8139too PCMCIA card I managed to get this 
warning:

find: WARNING: Hard link count (5) is wrong for /proc/bus/pci: this may be a 
bug in your filesystem driver.  Automatically turning on find's -noleaf 
option.  Earlier results may have failed to include directories that should 
have been searched.


Compiling pcmcia in the kernel (but leaving yenta and 8139too as a module) I 
never get errors on /proc/bus, but I get the same results on /proc/bus/pci.
It seems a broader hotplug problem. Of corse it could be already solved in 
2.6.14, as I can't reproduce it.

-- 
Bye,
   Massimiliano Hofer

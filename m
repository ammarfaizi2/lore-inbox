Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266669AbTGFNyj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 09:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266674AbTGFNyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 09:54:39 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:62735 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S266669AbTGFNye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 09:54:34 -0400
Date: Mon, 7 Jul 2003 00:08:37 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Arnd Bergmann <arnd@arndb.de>
cc: Thomas Spatzier <TSPAT@de.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: crypto API and IBM z990 hardware support
In-Reply-To: <200307022206.h62M6aFB025817@post.webmailer.de>
Message-ID: <Mutt.LNX.4.44.0307062353420.548-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jul 2003, Arnd Bergmann wrote:

> For built-in drivers, link order decides which implementation is 
> preferred. Consequently, hardware crypto drivers need to come before
> software implementations and must not register themselves if the 
> hardware is not found at initcall time.
> 
> For the module case, the aes-z990.o module could declare
> 'MODULE_ALIAS(aes-hw);', the simple patch below makes sure
> that any aes-hw module is preferred to the software aes
> module. If there is more than one hardware implementation
> available for an architecture, either the autoloader can be
> extended further, or modprobe has to be configured
> appropriately.

While this looks like it will work fine for the z990, it is a special case 
which does not address other requirements for hardware support (some 
initial requirements are listed at 
http://www.intercode.com.au/jamesm/crypto/hardware_notes.txt).

I'm not enthusiastic about adding infrastructure which is really just a
hack for some quaint hardware, and probably does not work towards
addressing more common hardware requirements.


- James
-- 
James Morris
<jmorris@intercode.com.au>



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbUBREXU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 23:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263595AbUBREXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 23:23:00 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:42397 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S263101AbUBREUB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 23:20:01 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6] IBM PowerPC Virtual Ethernet Driver 
In-reply-to: Your message of "Wed, 18 Feb 2004 11:45:20 +1100."
             <1077065118.1082.83.camel@gaston> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 18 Feb 2004 15:19:36 +1100
Message-ID: <7789.1077077976@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Feb 2004 11:45:20 +1100, 
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>BITFIELDS ARE EVIL !!!
>The compiler is perfectly free, afaik, to re-order them

Not it is not.  C standard (ISO/IEC 9899:1999 (E)), section 6.7.2.1.

10 ...  If enough space remains, a bit-field that immediately follows
   another bit-field in a structure shall be packed into adjacent bits
   of the same unit. ...

13 Within a structure object, the non-bit-field members and the units
   in which bit-fields reside have addresses that increase in the order
   in which they are declared. ...

There is no scope for a compiler to reorder the members or the bit
fields of a structure.


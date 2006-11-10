Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424364AbWKJGQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424364AbWKJGQK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 01:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966097AbWKJGQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 01:16:10 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:10119 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S966046AbWKJGQI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 01:16:08 -0500
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Matthew Wilcox <matthew@wil.cx>
cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: KDB blindly reads keyboard port 
In-reply-to: Your message of "Thu, 09 Nov 2006 21:28:03 PDT."
             <20061110042803.GU16952@parisc-linux.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 10 Nov 2006 17:15:57 +1100
Message-ID: <16089.1163139357@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox (on Thu, 9 Nov 2006 21:28:03 -0700) wrote:
>On Fri, Nov 10, 2006 at 03:23:20PM +1100, Keith Owens wrote:
>> Bjron, could you try kdb-v4.4-2.6.19-rc5-{common,ia64}-2 on your
>> problem system?  I changed kdb so it only uses the keyboard if at least
>> one console matches the pattern /^tty[0-9]*$/.  IOW, if the user
>> specifies an i8042 style console on the command line (or uses the
>> default with CONFIG_VT=y) then kdb will attempt to use that keyboard.
>> Otherwise kdb ignores a VT style console, even when the kernel is
>> compiled with CONFIG_VT=y.
>
>If I'm using an HP Integrity system with a USB keyboard, won't I still
>have a console that matches ^tty[0-9]*$ ?

Good point.  How about the console list must include /^tty[0-9]*$/
_and_ there must be an interrupt registered with a name of "i8042"
before KDB will attempt to access i8042 ports?


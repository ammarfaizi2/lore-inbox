Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbTDJW3a (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 18:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264215AbTDJW3a (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 18:29:30 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:28323
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262694AbTDJW33 (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 18:29:29 -0400
Subject: Re: Painlessly shrinking kernel messages (Re: kernel support for
	non-english user messages)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E95EB6D.4020004@techsource.com>
References: <3E95EB6D.4020004@techsource.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050010963.12494.132.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Apr 2003 22:42:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-10 at 23:08, Timothy Miller wrote:
> To be brief, the idea I came up with was to identify the 128 most common 
> words in kernel messages and replace them with single character values 
> above 127 which printk would decode on the way out.  Once the list was 
> determined, there would be a header file people could use, at their 
> leisure, to make stubstitutions.  So, for instance, instead of having this:

Not a totally crazy idea. You could also do 5pack and some of the other
string tricks people have used in time. You also dont need to do word
boundaries.

For embedded at least this is far from ludicrous as a concept. The
tricky piece for all of these is working out how to grab each printk
format string and do things to it. That lets you do compression,
removal, internationalisation, cataloguing ..



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262124AbUJZLtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbUJZLtH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 07:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbUJZLtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 07:49:07 -0400
Received: from webapps.arcom.com ([194.200.159.168]:30984 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S262124AbUJZLtD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 07:49:03 -0400
Message-ID: <417E39AE.5020209@arcom.com>
Date: Tue, 26 Oct 2004 12:49:02 +0100
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ryan Anderson <ryan@michonline.com>
CC: Linus Torvalds <torvalds@osdl.org>, Len Brown <len.brown@intel.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Versioning of tree
References: <1098254970.3223.6.camel@gaston> <1098256951.26595.4296.camel@d845pe> <Pine.LNX.4.58.0410200728040.2317@ppc970.osdl.org> <20041025234736.GF10638@michonline.com>
In-Reply-To: <20041025234736.GF10638@michonline.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Oct 2004 11:49:28.0890 (UTC) FILETIME=[D97E61A0:01C4BB51]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Anderson wrote:
> 
> Well, here's a patch that adds -BKxxxxxxxx to LOCALVERSION when a
> top-level BitKeeper tree is detected.
> [...]
>  LOCALVERSION = $(subst $(space),, \
>  	       $(shell cat /dev/null $(localversion-files)) \
> +	       $(subst ",,$(localversion-bk)) \

Surely there's no need for this?  Can't the script spit out an 
appropriate localversion* file instead?

Tools like Debian's make-kpkg have to work out the kernel version (for 
use in the package name etc.) and it would be preferable if the method 
for generating the version didn't change too often.

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/

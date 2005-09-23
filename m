Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbVIWCY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbVIWCY0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 22:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVIWCYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 22:24:25 -0400
Received: from thorn.pobox.com ([208.210.124.75]:23989 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S1751081AbVIWCYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 22:24:25 -0400
Message-ID: <4333674D.3070502@rtr.ca>
Date: Thu, 22 Sep 2005 22:24:13 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050728
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Libata for parallel ATA controllers
References: <1127408726.18840.126.camel@localhost.localdomain>
In-Reply-To: <1127408726.18840.126.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>
> Status info and patches are at
> 
> http://zeniv.linux.org.uk/~alan/IDE
> 
> Enjoy but remember this is very early code and don't use it for
> production!

And especially keep in mind, that libata has practically *no*
built-in error-handling or recovery mechanisms yet.  If a drive
gets into a "reset me to recover" state, then libata just might
require a reboot to recover, whereas the IDE subsystem will usually
try a reset operation at some point.

Not a problem with modern, mostly bug-free hardware (eg. most SATA),
but this could be an issue for some PATA interfaces.

Cheers


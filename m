Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751822AbWGZXyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbWGZXyR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 19:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbWGZXyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 19:54:17 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:32234 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751822AbWGZXyQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 19:54:16 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: [PATCH 2/2] usbhid: HID device simple driver interface
Date: Thu, 27 Jul 2006 01:54:12 +0200
User-Agent: KMail/1.9.1
Cc: liyu <liyu@ccoss.com.cn>, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Peter <peter@maubp.freeserve.co.uk>,
       The Doctor <thedoctor@tardis.homelinux.org>
References: <44C746F1.6090601@ccoss.com.cn> <20060726161055.GB28284@filer.fsl.cs.sunysb.edu>
In-Reply-To: <20060726161055.GB28284@filer.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607270154.14021.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 July 2006 18:10, Josef Sipek wrote:
> You should use (hid) instead of hid. Because of how the pre-processor works.
> 

Or, even better, use an inline function instead of a macro whereever
possible.

One more thing, the description for patch 1 can probably be refined
a bit more and put into Documentation/somewhere as a new file.

Regarding the split of the patch, it's usually a bad idea to 
put the header file into a separate patch from its users.
E.g. if someone during debugging tries to revert patch 2 but not
patch 1, he ends up with a broken build.

	Arnd <><

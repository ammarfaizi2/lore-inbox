Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbVCVVuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbVCVVuT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 16:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbVCVVuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 16:50:18 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:13207 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261993AbVCVVuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 16:50:01 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: 2.6.12-rc1-mm1: resume regression (was: Re: 2.6.12-rc1-mm1: Kernel BUG at pci:389)
Date: Tue, 22 Mar 2005 22:49:53 +0100
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Len Brown <len.brown@intel.com>, LKML <linux-kernel@vger.kernel.org>,
       Shaohua Li <shaohua.li@intel.com>
References: <20050322013535.GA1421@elf.ucw.cz> <1111464268.17329.27.camel@d845pe> <20050322110126.GB1780@elf.ucw.cz>
In-Reply-To: <20050322110126.GB1780@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503222249.54091.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday, 22 of March 2005 12:01, Pavel Machek wrote:
> Hi!
> 
> > Will this do it for the moment?
> 
> Its certainly better.

With the Len's patch applied I have to unload the modules:

ohci_hcd
ehci_hcd
yenta_socket

before suspend as each of them hangs the box solid during either
suspend or resume.  Moreover, when I tried to load the ehci_hcd
module back after resume, it hanged the box solid too.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

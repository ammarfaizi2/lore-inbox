Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbVACTVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVACTVf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 14:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbVACTVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 14:21:25 -0500
Received: from mx02.qsc.de ([213.148.130.14]:63171 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S261621AbVACTSR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 14:18:17 -0500
Message-ID: <41D999CD.80105@exactcode.de>
Date: Mon, 03 Jan 2005 20:15:25 +0100
From: Rene Rebe <rene@exactcode.de>
Organization: ExactCode
User-Agent: Mozilla Thunderbird 1.0 (X11/20041231)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: George Garvey <tmwg-sane@inxservices.com>
CC: sane-devel <sane-devel@lists.alioth.debian.org>,
       linux-kernel@vger.kernel.org, oliver@neukum.org, torvalds@osdl.org,
       marcelo.tosatti@cyclades.com
Subject: Please remove hpusbscsi Was: [sane-devel] HP 7450C, hpusbscsi, permissions
 in Fedora Core 3
References: <1104646290.5821.99.camel@localhost.localdomain> <20050102101258.GB8385@inxservices.com>
In-Reply-To: <20050102101258.GB8385@inxservices.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we should remove hpusbscsi from the Kernel. It is long obsolete and very 
unstable. I can send a patch for 2.4 and 2.6 (if needed) ;-)

George Garvey wrote:

> On Sat, Jan 01, 2005 at 10:11:30PM -0800, Thomas Frayne wrote:

...

>    As far as I know, Rene has made it pretty clear he doesn't want to
> use hpusbscsi with the avision driver. He prefers libusb.

Yes. Hpusbscsi has many drawbacks. The major ones are:

  - does not work with new scanners (that are designed for USB 2.0)
  - it is highly instable (e.g. during an i/o error it locks up
    quite easily and leaves the (usb sub-)system in a state that
    needs a reboot ...

The later problem made me add the user-space i/o code to the 
SANE/Avision backend, because I had to reboot my system every 5 minutes 
during development ...

Yours,

-- 
René Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
             http://www.exactcode.de | http://www.exactcode.de/t2
             +49 (0)30  255 897 45


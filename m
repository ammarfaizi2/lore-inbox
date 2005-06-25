Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVFYU4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVFYU4y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 16:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVFYU4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 16:56:54 -0400
Received: from opersys.com ([64.40.108.71]:25862 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261324AbVFYU4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 16:56:51 -0400
Message-ID: <42BDC7A9.7070906@opersys.com>
Date: Sat, 25 Jun 2005 17:07:53 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Sean Bruno <sean.bruno@dsl-only.net>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "Hodle, Brian" <BHodle@harcroschem.com>
Subject: Re: FW: PROBLEM: Devices behind PCI Express-to-PCI bridge not	mapped
References: <D9A1161581BD7541BC59D143B4A06294021FAA68@KCDC1>	 <42BDB338.9030800@opersys.com>  <1119729766.9540.0.camel@oscar.metro1.com> <1119729942.9614.1.camel@oscar.metro1.com>
In-Reply-To: <1119729942.9614.1.camel@oscar.metro1.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sean Bruno wrote:
> I got FC4 to install using the Silicon Image SATA controller and an IDE
> CDROM.  I also inserted a PCI 10/100 card to get network support.  After
> installing FC4(or any distro for that matter), edit your inittab before 
> you reboot and set it to boot into run level 3.  Once you have rebooted,
> you can run an update(via yum) to get the latest kernel and Xorg stuff.
> This allowed me to boot the machine into level 5 and my video card did
> function(NV 6200).

I actually never had problems with the video working, it always did
work. Given the information I have at hand, though, the video card
I'm using is apparently conflicting with the secondary IDE.

> I am assuming that this is causing some kind of weirdness that disables
> the use of the NV SATA, USB, Sound and the Broadcom ethernet device.
> Any ideas what the "OUT OF SPEC" warning actually means?

Well I don't know whether this is what is causing the weirdness that's
creating the ck804 problems, but I can confirm that I do get those exact
same "OUT OF SPEC" messages when running dmidecode.

Here's what google turns up:
https://bugzilla.redhat.com/bugzilla/attachment.cgi?id=114778

Looking at the dmidecode sources, it seems that it reports "OUT OF SPEC"
for anything it doesn't recognize. There's not much more about it in the
sources or the docs, from what I can see that is.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

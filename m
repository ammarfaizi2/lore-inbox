Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269261AbUJKVR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269261AbUJKVR4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 17:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269260AbUJKVRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 17:17:55 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:50053 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S269277AbUJKVRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 17:17:49 -0400
Subject: Re: Totally broken PCI PM calls
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: David Brownell <david-b@pacbell.net>
Cc: Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>
In-Reply-To: <200410110936.37268.david-b@pacbell.net>
References: <1097455528.25489.9.camel@gaston>
	 <Pine.LNX.4.58.0410101937100.3897@ppc970.osdl.org>
	 <16746.299.189583.506818@cargo.ozlabs.ibm.com>
	 <200410110936.37268.david-b@pacbell.net>
Content-Type: text/plain
Message-Id: <1097529469.4523.3.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 12 Oct 2004 07:17:50 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David.

On Tue, 2004-10-12 at 02:36, David Brownell wrote:
> I've made that point too.  STD is logically a few steps:  quiesce system,
> write image to swap, change power state.  The ACPI spec talks about
> that as keeping the system in a G1/S4 powered state, but "swusp"
> doesn't use that ... it does a full power-off.   And of course, full power-off
> means that the BIOS probably mucks with the USB hardware, so it's
> not a real resume any more.

That's not necessarily true. Swsusp and suspend2 both include support
for enter ACPI S4 state. For suspend2 it's optional (to allow for broken
bioses). Not sure about whether it is with swsusp.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbVCUDHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVCUDHG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 22:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVCUDHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 22:07:05 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:34100 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261502AbVCUDG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 22:06:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=j57M9RLZd7uiSWZpQJoN6T4RHA0TsrW5AeA9lUrfRNGAyNgC5AG8BX4CYkME9qzR2EaFWGpM4FrI4iNi9InJ/D5NV9a6w5MFgP8LL7frbLgkR50vO/HA3h21810Zm9T30vWbBdBPxjFmViI3w+n+tQoCT9qmNaetuK5s2kSMI/k=
Message-ID: <e0716e9f05032019064c7b1cec@mail.gmail.com>
Date: Sun, 20 Mar 2005 22:06:57 -0500
From: William Beebe <wbeebe@gmail.com>
Reply-To: William Beebe <wbeebe@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: forkbombing Linux distributions
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following quote is from the article "Linux Kernel Security, Again"
(http://www.securityfocus.com/columnists/308):

"Don't get me wrong. Linux doesn't suck. But I do believe that the
Linux kernel team (and some of the Linux distributions that are still
vulnerable to fork bombing) need to take proactive security a little
more seriously. I'm griping for a reason here -- things need to be
change."

Sure enough, I created the following script and ran it as a non-root user:

#!/bin/bash
$0 & $0 &

and ran it on Fedora Core 3 with kernel 2.6.11.5 (the box is an Athlon
XP 2500+ Barton with 512M on an nForce2 board). The system locked up
tighter than a drum. However... After about two minutes the system
"unlocked" and responsiveness returned to normal. I can see where this
would be an issue on a production system, especially if you could kick
off a new fork bomb to continuously lock the system.

Is this really a kernel issue? Or is there a better way in userland to
stop this kind of crap?

Regards

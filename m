Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbULNWfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbULNWfV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 17:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbULNWdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 17:33:36 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:10982 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S261716AbULNW3L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 17:29:11 -0500
Message-ID: <41BF6935.3040300@free.fr>
Date: Tue, 14 Dec 2004 23:29:09 +0100
From: Vince <fuzzy77@free.fr>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: cannot eject drive using pktcdvd
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see the following bug since I've enabled packet writing for my dvd 
drive (using the udftools package):

- eject won't open the tray unless I'm root

- whether I'm root or not, I get the following error when running eject:
     "eject: unable to eject, last error: Invalid argument"
   and in the system logs:
"program eject is using a deprecated SCSI ioctl, please convert it to SG_IO"

The command: pktsetup dvd /dev/cdrom ; eject
should allow anyone with a cd/dvd writer to reproduce this bug.

Disabling packet writing ("pktsetup -d dvd") solves the problem and 
everything works fine (no strange message in the logs).

I _think_ this could be related to Redhat bug 137349 
(https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=137349),
but I could be wrong...

Regards,

Vince

(Please CC: me as I'm not subscribed)

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbTLJJxx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 04:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbTLJJxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 04:53:53 -0500
Received: from mailgate3.globalintranet.net ([194.206.181.244]:18792 "EHLO
	relais-int3.globalintranet.net") by vger.kernel.org with ESMTP
	id S262796AbTLJJxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 04:53:51 -0500
X-Lotus-FromDomain: MGE-UPS
From: arnaud.quette@mgeups.com
To: reg@dwf.com
cc: Greg KH <greg@kroah.com>, Paul Stewart <stewart@wetlogic.net>,
       Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       linux-usb-users@lists.sourceforge.net, opensource@mgeups.com,
       "Charles Lepple" <clepple@ghz.cc>, reg@orion.dwf.com
Message-ID: <C1256DF8.003624D1.00@gin123.ftgin.com>
Date: Wed, 10 Dec 2003 10:54:24 +0100
Subject: =?iso-8859-1?Q?R=E9f._:_[Linux-usb-users]_Re:_USB/HID_UPS_issue_(?=
	=?iso-8859-1?Q?was_Re:_USB_scanner_issue)?=
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hi Reg,

> I havent anything to add to your comments, except to make sure you saw
> my comments about USB/HID problems that I have encountered with a UPS.
>
> Since the message was short, I reproduce it here:

Fine as I seem to have missed it.

---

>...
>    (1) When doing a read to get hiddev_event structures, 2.4 only
>    gave the 'real' events from the device that one expected.
>    Under 2.6.0-testx there are several ZERO event structures/sec
>    where the entire structure is ZERO, both hid and value.
>
>    For the current code there may be a 'real' event every few
>    seconds, and 5-10 of these zero events/sec.  I have no
>    idea where they are coming from.
>

I have logged this in bugzilla for some times, but didn't had
time to go deeper (http://bugzilla.kernel.org/show_bug.cgi?id=795)
Eric Penner also added: http://bugzilla.kernel.org/show_bug.cgi?id=1048

>    (2) In one thread the code does a select, followed by a read if
>    data is available.  If one just 'falls thru' to the read with
>    the few lines of code it takes to do the checking, one gets
>    up to 45000 messages/minute (750/sec) reading:
>
>        kernel: drivers/usb/input/hid-core.c: control queue full
>
>    If one puts a 1/10sec sleep between these two commands, the
>    error messages go away.
>
>Anyone know anything about either of these errors?
>Or how to report them to the USB people if you cant post to the USB lists?

About the "control queue full", Vojtech once made a patch  (I should still have
it somewhere. If you want to test it, tell me so...)

Lastly, the best way to report is still to mail to usd-users and usb-devel
lists. Otherwise, the above mentionned Linux' bugzilla is a good way too.

Arnaud



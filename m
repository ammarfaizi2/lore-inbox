Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbQJaPCI>; Tue, 31 Oct 2000 10:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129033AbQJaPB6>; Tue, 31 Oct 2000 10:01:58 -0500
Received: from mail-gw.fol.uk.net ([193.218.222.20]:19726 "EHLO
	mail-gw.fol.uk.net") by vger.kernel.org with ESMTP
	id <S129026AbQJaPBk>; Tue, 31 Oct 2000 10:01:40 -0500
Message-ID: <069c01c0434b$ad0c5a50$1400000a@farmline.com>
From: "Geoff Winkless" <geoff@farmline.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.17 & VM: do_try_to_free_pages failed / eepro100
Date: Tue, 31 Oct 2000 15:03:06 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Searching through the archives I found this post on Tue, Sep 12, 2000 at
09:41:13PM +0200 from Octave Klaba

> Hello,
> On a high load server, kernel has some errors:
>
> VM: do_try_to_free_pages failed for httpd...
> VM: do_try_to_free_pages failed for httpd...
> eth0: Too much work at interrupt, status=0x4050.
> eth0: Too much work at interrupt, status=0x4050.
>
> is there somewhere the new version of driver for eepro100
> to make a test ?

I'm wondering if anyone has found a solution for this: our mailserver is
exhibiting the same error message (although no mention of the eth0
interface, we do also use the eepro100):

Oct 31 12:12:14 mail-client kernel: VM: do_try_to_free_pages failed for
sendmail
...
Oct 31 12:12:14 mail-client last message repeated 2 times
Oct 31 12:12:14 mail-client kernel: VM: do_try_to_free_pages failed for
in.pop3d
...
Oct 31 12:12:14 mail-client kernel: VM: do_try_to_free_pages failed for
klogd...

Oct 31 12:12:23 mail-client last message repeated 14 times
Oct 31 12:12:23 mail-client kernel: VM: do_try_to_free_pages failed for
sendmail
...
Oct 31 12:12:23 mail-client last message repeated 15 times
Oct 31 12:12:23 mail-client kernel: VM: do_try_to_free_pages failed for
syslogd.
..
Oct 31 12:12:23 mail-client last message repeated 11 times
Oct 31 12:12:23 mail-client kernel: VM: do_try_to_free_pages failed for
in.pop3d
...
Oct 31 12:12:23 mail-client last message repeated 15 times
Oct 31 12:12:23 mail-client kernel: VM: do_try_to_free_pages failed for
sendmail
...
Oct 31 12:12:24 mail-client last message repeated 30 times
Oct 31 12:12:24 mail-client kernel: VM: do_try_to_free_pages failed for
kupdate.
..
Oct 31 12:12:24 mail-client kernel: VM: do_try_to_free_pages failed for
sendmail
...
Oct 31 12:12:25 mail-client last message repeated 42 times
Oct 31 12:12:25 mail-client kernel: VM: do_try_to_free_pages failed for
kupdate.
..
Oct 31 12:12:25 mail-client kernel: VM: do_try_to_free_pages failed for
sendmail
...
Oct 31 12:12:26 mail-client last message repeated 60 times
Oct 31 12:12:26 mail-client kernel: VM: do_try_to_free_pages failed for
kupdate.

... etc etc

To agree with Octave, this only appears to happen under load - over weekends
(our quiet periods) the syslog is nearly empty. In extremis it has been
necessary to reboot the machine by kicking the power button.

Any thoughts appreciated.

Running Redhat 6.2 (not my choice) on a single-processor PIII-650 with 128MB
RAM and 256MB swap. Load average is usually around the 0.3 mark. Kernel
(2.2.17) was compiled from source.

I'm not subscribed to the list, but I guess this is the only way to find an
answer - can you please copy me in on any replies. Thanks :0

Geoff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

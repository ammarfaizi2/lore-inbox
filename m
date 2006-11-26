Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967320AbWKZHLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967320AbWKZHLh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 02:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967322AbWKZHLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 02:11:37 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:38737 "EHLO
	pd3mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S967320AbWKZHLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 02:11:36 -0500
Date: Sun, 26 Nov 2006 01:11:33 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [patch] PM: suspend/resume debugging should depend on
 SOFTWARE_SUSPEND
In-reply-to: <fa.bo0iOgKqELDD50VEZpxeUpzPsMg@ifi.uio.no>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>
Message-id: <45693E25.9010504@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.U3NcOE+DHLOUMSq6HkaGglGl7hQ@ifi.uio.no>
 <fa.YMVQ6sabKF/IkEHUCoiQoxoHWZA@ifi.uio.no>
 <fa.c5fVj98hBgqoUumwbA9jymiSXr8@ifi.uio.no>
 <fa.zMBHTAXYfXNe2TVX89s3qsC2HRk@ifi.uio.no>
 <fa.yA6cvuiGulIRQfqY+E9joR2nWog@ifi.uio.no>
 <fa.bo0iOgKqELDD50VEZpxeUpzPsMg@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> Lots of other controllers don't work correctly on resume but thats much
> less of a problem and with UDMA misclocking generally turns into a CRC
> error storm and stop.
> 
> Andrew has about 2/3rds of the bits I've done now, will push the rest
> when I've done a little more testing/checking. At that point libata ought
> to be resume safe. Someone who cares about drivers/ide legacy support can
> then copy the work over.

btw, I have some code almost ready for sata_nv to add proper 
suspend/resume support. Unfortunately I have trouble testing it, since 
STR doesn't work on my machine since, guess what - the video doesn't 
come back! It doesn't even take the monitor out of standby mode. None of 
the acpi_sleep options seem to work, and vbetool appears to helpfully 
segfault on any operation so that's out. This is an NVIDIA SLI setup so 
that probably makes things a bit more complicated.

In any case, it should be better than what we have right now for 
suspend/resume support in sata_nv, namely the "do nothing, won't work 
(at least not for CK804 and later)" implementation..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


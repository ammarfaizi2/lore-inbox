Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbUBTVEu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 16:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbUBTVDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 16:03:04 -0500
Received: from gprs151-132.eurotel.cz ([160.218.151.132]:2945 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261412AbUBTVCM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 16:02:12 -0500
Date: Fri, 20 Feb 2004 22:01:58 +0100
From: Pavel Machek <pavel@ucw.cz>
To: John Levin <levin@gamebox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc3 messages  BUG
Message-ID: <20040220210158.GA32023@elf.ucw.cz>
References: <20040221075308.161992c7.levin@gamebox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040221075308.161992c7.levin@gamebox.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 	My guess atleast in this case is that  suspend/resume cyle looses track
> of the fact that a module is use.I have file corruption. All those
> files which have been created after resume is corrupted. I copied dmesg
> into a backup file and saved it. When i boot 2.4 and look into it , it
> is corrputed.
> 	After booting I connect to the internet through wvdial. So i have to
> load up usbcore,cdc_acm,uhci. i am connected to the net and searching on
> google.	Now i do echo 4 > /proc/acpi/sleep . It suspends. Then i resume
> it from command line.
>  So now wvdial looks as if connected but really isn't. So i close it and
> try running it again. It doesn't detect /dev/usb/acm/0. So i remove the
> modules and try inserting it (uhci) which gives me the error.
> 
> Here is something which i could copy after resume.

Try it with minimal config, and without modules. Be sure to fsck so
you don't kill your filesystem totally. Try 2.6.3.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423360AbWJURVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423360AbWJURVh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 13:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423364AbWJURVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 13:21:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:25937 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423360AbWJURVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 13:21:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=hegt3mO5/bpRiWKAK7+g/Snc+LCGaGlyqHlZsEanlK/G5kbvV2wXVHdHtY3jOn17vGMLxG6bx1WZxR9TuPL0hsBMnGuOYElONig19XFJLFDGAs2rN2ux/Hfl49z+l6Mwt1f+NAvEMvYGEifGKyQts3dzVzkOvMXRHmdi+iUTVxg=
Message-ID: <727e50150610211021s7779b787s7bac8f409a3f2518@mail.gmail.com>
Date: Sat, 21 Oct 2006 13:21:33 -0400
From: "Aaron Cohen" <aaron@assonance.org>
To: "LKML List" <linux-kernel@vger.kernel.org>
Subject: Ordering hotplug scripts vs. udev device node creation
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: cb5060c770293c29
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hope this is a reasonable list to post this to.

I'm trying to modify the gpsd hotplug script to work better with my
udev setup.  My USB serial devices are added to /dev/tts/USBx by udev
and the default script assumes they are /dev/ttyUSBx.

In any event, my hotplug script uses udevinfo to figure out the device
file to use.  The problem seems to be though that my hotplug script is
getting run before udev has actually created the device node.  Is
there some ordering mechanism I'm missing that would help me out here?

Thanks,
Aaron

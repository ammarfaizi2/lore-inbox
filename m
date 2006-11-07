Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965552AbWKGRCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965552AbWKGRCl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 12:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965554AbWKGRCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 12:02:41 -0500
Received: from lngw1.bjservices.com ([207.193.159.253]:4498 "EHLO
	lngw02.BJSERVICES.COM") by vger.kernel.org with ESMTP
	id S965552AbWKGRCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 12:02:39 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: usb device descriptor read/64, error -110 information.
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 6.5.1 January 21, 2004
Message-ID: <OF141C7738.E35FF3F4-ON8625721F.005BA49A-8625721F.005D8CDE@BJSERVICES.COM>
From: John.Jeffers@bjservices.com
Date: Tue, 7 Nov 2006 10:59:30 -0600
X-MIMETrack: Serialize by Router on LnGW02/BJSUSA/BJSERVICES(Release 6.5.4FP2|September
 12, 2005) at 11/07/2006 11:00:20,
	Serialize complete at 11/07/2006 11:00:20
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I too have done this with High speed USB devices: SanDisk Micro 
Bonzai sold by Simpletech.  My dmesg was device descriptor read/64 error 
-71

The work around works for me with SuSE 10.1 Kernel build 2.6.16.21-0 25 
built Tuesday 19th Sept 2006 6:46:56 AM CDT on eisler.suse.de

What appears to be going on is that after so many entries in a USB table 
(which is the SCSI Stub) the High Speed Devices no longer can create an 
entry in the appropriate time.

Personally I would vote that this is a module issue.  However it did not 
appear until unit was updated to above kernel.  Google gives many hits on 
"descriptor read/64 error -71"

Same SuSE configuration was on P4 2.2G HP xt395 Laptop 1G/60G(12 Mhz USB), 
Micron Clientpro PIII 1G 512M/40G (12MHZ USB) and Micron Clientpro PIII 1G 
512M/60G on same hour/day so was quite repeatable.

USB drive was placed in W2K and XPro boxes and was recognized immediately



Regards John

>From http://ubuntuforums.org/archive/index.php/t-27416.html

Morgoth
April 16th, 2005, 01:50 AM
HI all.
I am having a little trouble with my USB thumb drive. I have successfully 
installed Kubuntu on both my laptop and desktop systems, however I cannot 
get my thumb drive to work on my desktop. It works fine in the same 
computer on my Windows ( sigh, I know ) XP partition and it works great on 
the laptop, so I figure it can't be the usb port or the drive itself. I 
think something got broken when I installed but I'm still fairly new when 
it comes to ripping around in the guts of Linux and am not sure where to 
even start looking. 
I have tried to mount the drive manually, but got an error saying no 
device ( sda1... or sdb1... ) and in fact there are no entries at all in 
/dev for sd"anything".
When I insert the drive and do a dmesg, it shows the following errors:

usb 4-6: new high speed USB device using ehci_hcd and address 2
usb 4-6: device descriptor read/64, error -71
usb 4-6: new high speed USB device using ehci_hcd and address 3
usb 4-6: device descriptor read/64, error -71
usb 4-6: new high speed USB device using ehci_hcd and address 4
usb 4-6: device descriptor read/64, error -71
usb 4-6: new high speed USB device using ehci_hcd and address 5
usb 4-6: device descriptor read/64, error -71
usb 4-6: device descriptor read/64, error -71
usb 4-6: new high speed USB device using ehci_hcd and address 6
usb 4-6: device descriptor read/64, error -71
usb 4-6: device descriptor read/64, error -71

If anyone out there has seen this or has any insight into my problem I 
would greatly appreciate a reply.

robajz
June 3rd, 2005, 01:33 AM
Hi,

I found this 
https://www.redhat.com/archives/fedora-list/2005-March/msg04036.html
... type, as root, modprobe -r ehci-hc ...

it's just workaround but worked for me, don't know why. May be next kernel 
release may fix it.

robajz

Morgoth
June 3rd, 2005, 01:58 PM
IT WORKS!! :) 
I cannot thank you enough Robajz ( first born ok? )
As you can tell I posted this 2 months ago and nothing. I had just about 
given up trying to find a solution. I know it's not a life-threatening 
situation, but it was inconvenient.

Once again thank you.
Morgoth

John Jeffers P.Eng. , MS1074
Software Applications Engineering
11211 FM 2920, Tomball, TX, 77375
281.357.2773, 281.357.5491 Fax

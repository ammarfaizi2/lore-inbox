Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262669AbRE0BHo>; Sat, 26 May 2001 21:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262672AbRE0BHe>; Sat, 26 May 2001 21:07:34 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:48388 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262669AbRE0BHW>;
	Sat, 26 May 2001 21:07:22 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Marc Schiffbauer <marc.schiffbauer@links2linux.de>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: new aic7xxx oopses with AHA2940 
In-Reply-To: Your message of "Sat, 26 May 2001 18:05:29 +0200."
             <20010526180529.A7595@lisa.links2linux.home> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 27 May 2001 11:07:16 +1000
Message-ID: <21164.990925636@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 May 2001 18:05:29 +0200, 
Marc Schiffbauer <marc.schiffbauer@links2linux.de> wrote:
>I have problems with the new aic7xxx-Driver. These problems exist
>with vanilla (2.4.4, 2.5.5, other d.k.) and -ac
>May 26 17:52:33 homer kernel: EIP:    0010:[usbcore:usb_devfs_handle_Re9c5f87f+161255/198895517]
>May 26 17:52:33 homer kernel: Call Trace: [usbcore:usb_devfs_handle_Re9c5f87f+162269/198894503] [usbcore:usb_devfs_handle_Re9c5f87f+164966/198891806] [__delay+19/48] [usbcore:usb_devfs_handle_Re9c5f87f+166493/198890279] [usbcore:usb_devfs_handle_Re9c5f87f+117712/198939060] [usbcore:usb_devfs_handle_Re9c5f87f+185577/198871195] [usbcore:usb_devfs_handle_Re9c5f87f+171751/198885021] 
>
>Does it crash with the USB-Driver?? But USB works fine... even after
>the Oops

Because you are using a broken version of klogd that stuffs up oops
traces.  Change klogd to run as klogd -x (probably in
/etc/rc.d/init.d/syslog) so it keeps its broken fingers off the oops.

Since you are failing during modprobe, creating /var/log/ksymoops is a
good idea, man insmod, see KSYMOOPS ASSISTANCE.  Reproduce the
problem to get a clean oops trace then run it through ksymoops, using
the saved module data in /var/log/ksymoops.


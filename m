Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272049AbRH2TGe>; Wed, 29 Aug 2001 15:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272050AbRH2TGY>; Wed, 29 Aug 2001 15:06:24 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:57095 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S272049AbRH2TGL>;
	Wed, 29 Aug 2001 15:06:11 -0400
Date: Wed, 29 Aug 2001 12:04:40 -0700
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Diet /sbin/hotplug package released
Message-ID: <20010829120440.B12825@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to announce the initial version of the Diet /sbin/hotplug
package.  It can be found at:
	http://prdownloads.sourceforge.net/linux-hotplug/diethotplug-0.1.tar.gz

Q: What is it?
A: It's a replacement for the current linux-hotplug script package.  It
   is written in C and if compiled with dietLibc[0], can produce a very
   small program.

   For instance, on my machine the /lib/modules/2.4.9-ac3/modules.usbmap
   is 59221 bytes.  The current linux-hotplug system needs this file,
   plus all of the linux-hotplug scripts and bash and awk to work.
   diethotplug compiles to about 20K on my machine and does not need
   modules.usbmap or any other helper programs to work.

Q: Will this replace the current linux-hotplug script package?
A: NO!  The current linux-hotplug scripts work quite well in a general
   purpose machine.  They do not need to be modified for each kernel
   version, and allow users to add their own scripts quite easily.
   
   The diethotplug program is only useful for systems that have memory
   constraints, do not have awk or bash, and do not change kernel
   versions (as the modules.pcimap and modules.usbmap are compiled into
   the program.)  Embedded systems and the upcoming 2.5 initrd method of
   kernel booting are good applications for this program.

Currently usb module loading works (tested on my limited range of
devices.)  More testing on other usb devices is most welcome.  PCI
loading of modules is next on the list of things to do.

thanks,

greg k-h

[0] http://www.fefe.de/dietlibc/

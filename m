Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280251AbRK1TVJ>; Wed, 28 Nov 2001 14:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280153AbRK1TU4>; Wed, 28 Nov 2001 14:20:56 -0500
Received: from [209.113.159.17] ([209.113.159.17]:30850 "HELO
	gold.auroratech.com") by vger.kernel.org with SMTP
	id <S280084AbRK1TUJ>; Wed, 28 Nov 2001 14:20:09 -0500
Message-ID: <3C053888.89D3FD82@aol.com>
Date: Wed, 28 Nov 2001 14:18:32 -0500
From: Joachim Martillo <ThorsProvoni@aol.com>
Organization: Anbaric Pinscher, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-4GB i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: martillo@telfordtools.com
Subject: 3 Questions
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1) I have built a multifunction driver to support the Aurora
Technologies, Inc. serial adapter cards and expansion units that use
Siemens/Infineon SAB 82532 and SAB 82538 (ESCC2 and ESCC8) enhanced
serial communications controllers.  This driver supports asynchronous
TTYs, synchronous TTYs, an Ethernet-like synchronous serial Network
driver, and a packet-oriented character device to facilitate the
portation to Linux of synchronous protocol applications that have been
implemented with putmsg and getmsg on proprietary Unix systems.  (A
patch for those interested in trying the driver will be put up on one
of my web pages shortly.)  I took the SPARC Linux SAB 82532 serial
asynchronous TTY driver as a starting point and kept the
block_til_ready logic that arbitrates access between the cua and ttyS
devices because it seemed helpful in arbitrating access to a physical
port among the asynchronous TTY, asynchronous call out, synchronous
TTY, Network and character device functionalities.  From reviewing the
archive, I noticed that the cua devices have been deprecated, and that
now apparently callout and asynchronous terminal connectivity are
supposed to be managed through a single port.  I am not sure how
asynchronous dialout for synchronous TTYs, synchronous Network devices
and the synchronous character device can be managed without a separate
asynchronous callout device to communicate with the modem before the
synchronous connection is set up.  I suppose I could modify the
asynchronous TTY device so that it could be bimodal and switch back
and forth between synchronous and asynchronous mode, but a similar
procedure would be hard for the synchronous character device and very
hard for the synchronous network device.  How is dialout supposed to
be handled for asynchronous dialup modems that can set up synchronous
point-to-point connections on demand?

2) Are the other PCI or (E)ISA serial adapter cards that use the
SAB82532 and SAB82538 enhanced serial communications controller?
I could add support for them into this driver.

3) Aurora wants to track the driver in its source control system, but
they have ISO 900X procedures that require maintaining the build
environment under CVS.  The build environment is basically the kernel
against which it is developed.  But new developer kernels are released
fairly regularly (unlike new versions of Solaris or True64).  Do
maintainers of such driver software commonly maintain development
environments across a complete range (e.g., all 2.4.* kernels)?  Is
there a FAQ with recommendations to help a hardware vendor deal with
the nitty gritty details of making sure its driver software works
properly across such a range of rapidly changing development
environments?


Joachim Martillo
Telford Tools, Inc.
martillo@telfordtools.com


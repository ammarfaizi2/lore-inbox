Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265420AbRF0Vwa>; Wed, 27 Jun 2001 17:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265421AbRF0VwU>; Wed, 27 Jun 2001 17:52:20 -0400
Received: from 24-25-197-107.san.rr.com ([24.25.197.107]:61458 "HELO
	acmay.homeip.net") by vger.kernel.org with SMTP id <S265420AbRF0VwD>;
	Wed, 27 Jun 2001 17:52:03 -0400
Date: Wed, 27 Jun 2001 14:52:01 -0700
From: andrew may <acmay@acmay.homeip.net>
To: linux-kernel@vger.kernel.org
Subject: What is the best way for multiple net_devices
Message-ID: <20010627145201.A23834@ecam.san.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a standard way to make multiple copies of a network device?

For things like the bonding/ipip/ip_gre and others they seem to expect
insmod -o copy1 module.o
insmod -o copy2 module.o

It seems to me that this will waste space creating copies of all the 
static data.

Then there are things like ipsec that create a few static net_dev
structures, but I have no idea how they deal with more entries. 
They probably don't.

The PCI drivers seem to be pretty clean with init_one type functions.

Is there anything similar for generic hardware-less network devices.

I would hate to have write an ioctl to create a new device without
loading a module twice.

--
Andrew May
acmay@acmay.homeip.net

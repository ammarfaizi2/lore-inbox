Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265430AbRF0WDu>; Wed, 27 Jun 2001 18:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265429AbRF0WDk>; Wed, 27 Jun 2001 18:03:40 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:31942 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S265427AbRF0WDY>;
	Wed, 27 Jun 2001 18:03:24 -0400
Message-ID: <3B3A5852.AAEF9531@mandrakesoft.com>
Date: Wed, 27 Jun 2001 18:04:02 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: andrew may <acmay@acmay.homeip.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What is the best way for multiple net_devices
In-Reply-To: <20010627145201.A23834@ecam.san.rr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andrew may wrote:
> 
> Is there a standard way to make multiple copies of a network device?
> 
> For things like the bonding/ipip/ip_gre and others they seem to expect
> insmod -o copy1 module.o
> insmod -o copy2 module.o

The network driver should provide the capability to add new devices.

Most drivers currently have the capability to do N devices, where N is
some constant set at compile time.  Typically you use ifconfig, a
special-purpose userland program, or sometimes even sysctls to configure
additional net devices.

It's certainly possible to modify the driver to create additional
network interfaces on the fly, but a lot of drivers are not coded to do
that at present.

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |

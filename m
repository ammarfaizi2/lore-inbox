Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278249AbRJMCpN>; Fri, 12 Oct 2001 22:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278248AbRJMCpD>; Fri, 12 Oct 2001 22:45:03 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:6417 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S278249AbRJMCoz>;
	Fri, 12 Oct 2001 22:44:55 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Matt Domsch <Matt_Domsch@dell.com>, linux-kernel@vger.kernel.org
Subject: Re: crc32 cleanups 
In-Reply-To: Your message of "Fri, 12 Oct 2001 21:36:45 EST."
             <Pine.LNX.3.96.1011012213105.20962B-100000@mandrakesoft.mandrakesoft.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 13 Oct 2001 12:45:11 +1000
Message-ID: <15207.1002941111@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2001 21:36:45 -0500 (CDT), 
Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
>On Sat, 13 Oct 2001, Keith Owens wrote:
>> It is better to define CONFIG_CRC32 and have the Config.in files set
>> CONFIG_CRC32 for selected drivers.  That avoids the problem of lots of
>> drivers wanting to patch the same Makefile, instead the selection of
>> crc32 is kept with the driver selection.
>
>No, because that doesn't take care of the module case (CONFIG_CRC32=m).

Don't build crc32.o as a module, if it is required at all then make it
built in.  Building small service routines as modules is a waste of
space, they take up complete pages when they are loaded.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266907AbRGMBMN>; Thu, 12 Jul 2001 21:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266911AbRGMBMD>; Thu, 12 Jul 2001 21:12:03 -0400
Received: from femail1.sdc1.sfba.home.com ([24.0.95.81]:54214 "EHLO
	femail1.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S266907AbRGMBLs>; Thu, 12 Jul 2001 21:11:48 -0400
Date: Thu, 12 Jul 2001 18:11:20 -0700
From: tas@mindspring.com
Content-Type: text/plain;
	format=flowed;
	charset=us-ascii
X-Mailer: Apple Mail (2.388)
Cc: Ian Stirling <root@mauve.demon.co.uk>
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0 (Apple Message framework v388)
Content-Transfer-Encoding: 7bit
Subject: Re: Switching Kernels without Rebooting?
Message-Id: <20010713011144.KYIT26599.femail1.sdc1.sfba.home.com@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > I've just suspended to disk after the list line, pulled the power 
supplies,
 > taken the RAM chip out, shorted the pins to make really sure, then 
powered
 > back up.

FYI: Taking the memory module out and shorting its pins together is a 
great way to unnecessarily risk zapping your RAM with ESD, and a 
terrible way to ensure that its contents are erased.  When the DRAM is 
not being accessed (by definition true when you remove power), the gate 
capacitors that form the DRAM array are floating unconnected and cannot 
be intentionally discharged.  You just have to wait for good old leakage 
to kill the bits.  A minute should be more than enough.

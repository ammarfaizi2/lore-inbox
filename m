Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317298AbSHOSJa>; Thu, 15 Aug 2002 14:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317302AbSHOSJa>; Thu, 15 Aug 2002 14:09:30 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:25350 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id <S317298AbSHOSJ3>; Thu, 15 Aug 2002 14:09:29 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: henrique <henrique@cyclades.com>
Reply-To: henrique@cyclades.com
Organization: Cyclades Corporation
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Problem with random.c and PPC
Date: Thu, 15 Aug 2002 15:14:51 +0000
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200208151514.51462.henrique@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !!!

I am trying to use a program (ipsec newhostkey) that uses the random device 
provided by the linux-kernel. In a x86 machine the program works fine but 
when I tried to run the program in a PPC machine it doesn't work.

Looking carefully I have discovered that the problem is in the driver 
random.c. When the program tries to read any amount of data it locks and 
never returns. It happens because the variable  "random_state->entropy_count" 
is always zero, that is, any random number is generated at all !!!??.

Does anyone know anything about this problem ? Any sort of help is very 
welcomed.

Thanks
Henrique Gobbi


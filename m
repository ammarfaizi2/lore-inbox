Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262742AbTCVL5f>; Sat, 22 Mar 2003 06:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262744AbTCVL5f>; Sat, 22 Mar 2003 06:57:35 -0500
Received: from hermes.domdv.de ([193.102.202.1]:50183 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S262742AbTCVL5d>;
	Sat, 22 Mar 2003 06:57:33 -0500
Message-ID: <3E7C5241.1030206@domdv.de>
Date: Sat, 22 Mar 2003 13:08:33 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en, de-de, de
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.20: highmem and ldt allocation failure
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be something fishy with highmem in 2.4.20:

Using XFree86 4.3.0 (Matrox G550) and KDE 3.1.1 works with the following
kernel configuration options:

CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM is not set

However I do get "ldt allocation failed" messages, heavy swapping and an
unuseable GUI (needs to be killed from a console) just by activating the
KDE blank screen screensaver with the following kernel configuration
options:

# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_HIGHIO=y

Other processes (command line) do fail too in this case (e.g. ls) with 
the same ldt kernel message. The system is not loaded (about 110 to 120 
processes) and mostly idle when this problem occurs.

The system consists of: AMD XP2400+/Asus A7V8X/1GB DDR (PC266).
-- 
Andreas Steinmetz



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbTJFKEO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 06:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbTJFKEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 06:04:14 -0400
Received: from www01.ies.inet6.fr ([62.210.153.201]:30109 "EHLO
	smtp.ies.inet6.fr") by vger.kernel.org with ESMTP id S261345AbTJFKEM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 06:04:12 -0400
Message-ID: <3F813E19.7020303@inet6.fr>
Date: Mon, 06 Oct 2003 12:04:09 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030903 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Schwarz <usenet@andreas-s.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Extremely low disk performance on K7S5A Pro
References: <slrnbnoi5i.3re.usenet@home.andreas-s.net>
In-Reply-To: <slrnbnoi5i.3re.usenet@home.andreas-s.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwarz said the following on 10/02/2003 05:47 PM:

>Hi,
>
>since I replaced my Abit KT7 with an Elitegroup K7S5A Pro (SIS735), I've
>got extremly low disk performance with every tested kernel version
>(2.4.20, 2.6.0-test6-mm2):
>
># hdparm -tT /dev/hda                                                           
>/dev/hda:                                                                       
> Timing buffer-cache reads:   824 MB in  2.00 seconds = 411.65 MB/sec           
> Timing buffered disk reads:   10 MB in  3.28 seconds =   3.05 MB/sec
>                                                          ^^^^
>
>DMA, 32bit etc. is activated (hdparm -d1 -c3 -u1 /dev/hda):
>
>  
>

3.05 MB is even less than what I'm used to see with most drives and *PIO 
4* !

Is there any ide message in /var/log/messages ?

I see you use hdparm to setup the drive/controller settings. I advise 
you to let the kernel autotune the transfer modes by itself.

Could you send us :
- the exact kernel version,
- your kernel compilation config file,
- any kernel parameters provided,
- the content of /var/log/dmesg,
- the output of `lspci -vvxxx`,
- the ouput of `cat /proc/ide/sis`

Best regards,

-- 
Lionel Bouton - inet6
---------------------------------------------------------------------
   o              Siege social: 51, rue de Verdun - 92158 Suresnes
  /      _ __ _   Acces Bureaux: 33 rue Benoit Malon - 92150 Suresnes
 / /\  /_  / /_   France
 \/  \/_  / /_/   Tel. +33 (0) 1 41 44 85 36
  Inetsys S.A.    Fax  +33 (0) 1 46 97 20 10
 



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264091AbTEOPkn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 11:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264092AbTEOPkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 11:40:42 -0400
Received: from www02.ies.inet6.fr ([62.210.153.202]:61056 "EHLO
	smtp.ies.inet6.fr") by vger.kernel.org with ESMTP id S264091AbTEOPki
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 11:40:38 -0400
Message-ID: <3EC3B7F1.4050105@inet6.fr>
Date: Thu, 15 May 2003 17:53:21 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030314
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcin@MWiacek.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [SiS IDE patch] various fixes
References: <000601c31adb$2e8bf4f0$400063d9@marcin>
In-Reply-To: <000601c31adb$2e8bf4f0$400063d9@marcin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcin Wiacek wrote:

>I wanted to check if very carefully (Sis 655). DMA seems to be enabled
>for HDD. But still there are some problems OR with 2.4.21 at all (I
>quess something wrong generally in IDE support) OR still with Sis
>driver. Why ? It seems, that DMA is NOT enabled for DVD and CDRW. I hear
>it - they work very slow. Also hdparm shows errors, when get info about
>them. In attachments examples.
>

These errors are normal (the requested info is meaningless on CD/DVD 
drives).

 From the .config you sent, " CONFIG_IDEDMA_ONLYDISK is not set ", so 
dma being disabled for your CD/DVD drives may be related to them having 
bugs in DMA mode, the kernel IDE subsystem disables DMA or higher dma 
modes with peripherals it knows to be buggy. Please send the output of 
"hdparm -i /dev/<yourdrive>"


>
>Also there are some problems with Silicon Image driver (see
>"DriveReadySeekCompleteError" in syslog). Because of it rather there is
>problem with 2.4.21.
>  
>

IIRC this message is in fact harmless, do you have any other problem 
with the harddrive ?

Regards,

-- 
Lionel Bouton - inet6
---------------------------------------------------------------------
   o              Siege social: 51, rue de Verdun - 92158 Suresnes
  /      _ __ _   Acces Bureaux: 33 rue Benoit Malon - 92150 Suresnes
 / /\  /_  / /_   France
 \/  \/_  / /_/   Tel. +33 (0) 1 41 44 85 36
  Inetsys S.A.    Fax  +33 (0) 1 46 97 20 10
 



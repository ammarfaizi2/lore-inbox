Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263479AbRFFF0f>; Wed, 6 Jun 2001 01:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263481AbRFFF0Z>; Wed, 6 Jun 2001 01:26:25 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:48698 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S263479AbRFFF0Q>; Wed, 6 Jun 2001 01:26:16 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: David Ford <david@blue-labs.org>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac9 
In-Reply-To: Your message of "Tue, 05 Jun 2001 21:55:39 MST."
             <3B1DB7CB.5090509@blue-labs.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 06 Jun 2001 15:25:51 +1000
Message-ID: <28279.991805151@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Jun 2001 21:55:39 -0700, 
David Ford <david@blue-labs.org> wrote:
>Quite positive it's the right map file.  I used -m and specified the 
>exact file.
>
>Jeff Garzik wrote:
>
>>David Ford wrote:
>>
>>> >>EIP; c01269f9 <proc_getdata+4d/154>   <=====
>>>Trace; c01b1021 <read_eeprom+131/1a8>
>>
>>This trace looks corrupted to me... are you sure that System.map for the
>>crashed kernel matches -exactly- with the one ksymoops used to decode
>>this?

The trace definitely looks suspect, I cannot see any BUG() calls in
proc_getdata(), even looking at the object code.

Does
  objdump --start-address=0xc01269f9 --stop-address=0xc0126a10 vmlinux
show the same code bytes, starting with ud2a?  I will be surprised if
it does.  If it does not then you definitely have the wrong System.map
for the oops.


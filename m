Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262598AbTCZWl5>; Wed, 26 Mar 2003 17:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262605AbTCZWl5>; Wed, 26 Mar 2003 17:41:57 -0500
Received: from intra.cyclades.com ([64.186.161.6]:18852 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP
	id <S262598AbTCZWl4>; Wed, 26 Mar 2003 17:41:56 -0500
Message-ID: <3E81BE5C.400@cyclades.com>
Date: Wed, 26 Mar 2003 14:51:08 +0000
From: Henrique Gobbi <henrique2.gobbi@cyclades.com>
Reply-To: henrique.gobbi@cyclades.com
Organization: Cyclades Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Interpretation of termios flags on a serial driver
References: <1046909941.1028.1.camel@gandalf.ro0tsiege.org> <20030326092010.3EDA8124023@mx12.arcor-online.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If this is not the right forum to discuss this matter, excuse me. Please 
point me to the right place.

I'm having some problems understanding three flags on the termios 
struct: PARENB, INPCK, IGNPAR. After reading the termios manual a couple 
of times I'm still not able to understand the different purposes of 
these flags.

What I understood:

1 - PARENB: if this flag is set the serial chip must generate parity 
(odd or even depending on the flag PARODD). If this flag is not set, use 
parity none.

2 - IGNPAR: two cases here:
    	2.1 - PARENB is set: if IGNPAR is set the driver should ignore 			all 
parity and framing errors and send the problematic bytes to 		tty flip 
buffer as normal data. If this flag is not set the 			driver must send the 
problematic data to the tty as problematic 		data.

	2.2 - PARENB is not set: disregard IGNPAR

What I don't understand:

3 - Did I really understand the items 1 and 2 ?

4 - INPCK flag: What's the purpose of this flag. What's the diference in 
relation to IGNPAR;

5 - If the TTY knows the data status (PARITY, FRAMING, OVERRUN, NORMAL), 
why the driver has to deal with the flag IGNPAR. Shouldn't the TTY being 
doing it ?

Thanks in advance
Henrique


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316567AbSEPDSB>; Wed, 15 May 2002 23:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316568AbSEPDSA>; Wed, 15 May 2002 23:18:00 -0400
Received: from 60.54.252.64.snet.net ([64.252.54.60]:19263 "EHLO
	hotmale.boyland.org") by vger.kernel.org with ESMTP
	id <S316567AbSEPDR7>; Wed, 15 May 2002 23:17:59 -0400
Message-ID: <3CE324D9.60905@blue-labs.org>
Date: Wed, 15 May 2002 23:17:45 -0400
From: David <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0+) Gecko/20020509
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lee@ricis.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: please help with pppoe
In-Reply-To: <200205151214.AA22282484@imail.ricis.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lee Leahu wrote:

>hello,
>
>by now i am very frusterated because i'm not sure whats going on and i don't have any clue on whats required to fix this.
>
>i'm trying to get pppoe to work from linux.  i already have it working from windows nt and windows xp.
>
>i am running suse 7.3 professional.
>my kernel is 2.4.16-4gb (k_deflt made by suse)
>
>i have these packages installed
>smpppd-0.49-7 (and yes, smpppd is running)
>ppp-2.4.1-170
>rp-pppoe-3.4-1
>  
>

I'm using the rp pppoe patch and 2.4.19-pre6.  I setup my options/user 
file and ran 'pppd eth0', worked perfectly the first time.

# cat /etc/ppp/options         
plugin rp-pppoe.so
name <username>
nodefaultroute

# cat /etc/ppp/pap-secrets 
<username> * <password>

# pppd --version
Warning: plugin rp-pppoe.so has no version information
Plugin rp-pppoe.so loaded.
RP-PPPoE plugin version 3.3 compiled against pppd 2.4.2b1
pppd version 2.4.2b1

I don't use the DSL connection as my default route thus the 
'nodefaultroute' statement.

It works very well save for frequent but seemingly innocuous OOPses.

-d



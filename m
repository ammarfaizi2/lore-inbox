Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131878AbRCXXiB>; Sat, 24 Mar 2001 18:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131887AbRCXXhv>; Sat, 24 Mar 2001 18:37:51 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:14582 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S131878AbRCXXhl>; Sat, 24 Mar 2001 18:37:41 -0500
Message-Id: <l0313031eb6e2dfb37759@[192.168.239.101]>
In-Reply-To: <Pine.LNX.4.21.0103241910340.1863-100000@imladris.rielhome.conectiva>
In-Reply-To: <l0313031ab6e2b9537342@[192.168.239.101]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 24 Mar 2001 23:36:31 +0000
To: Rik van Riel <riel@conectiva.com.br>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: [PATCH] Prevent OOM from killing init
Cc: Doug Ledford <dledford@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>         free = atomic_read(&buffermem_pages);
>>         free += atomic_read(&page_cache_size);
>>         free += nr_free_pages();
>> -       free += nr_swap_pages;
>
>> +       /* Since getting swap info is expensive, see if our allocation
>>can happen in physical RAM */
>
>Actually, getting swap info is as cheap as reading the variable
>nr_swap_pages. I should fix this in the OOM killer ;)

Just fixed that for myself (in both places) and about to test.  I'm almost
sure I actually encountered an error related to this, but I'll retest and
make sure...

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
-----END GEEK CODE BLOCK-----



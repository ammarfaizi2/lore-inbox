Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264829AbTLQXZB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 18:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264830AbTLQXZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 18:25:00 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:31699 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S264829AbTLQXY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 18:24:57 -0500
Message-ID: <3FE0E5C6.5040008@labs.fujitsu.com>
Date: Thu, 18 Dec 2003 08:24:54 +0900
From: Tsuchiya Yoshihiro <tsuchiya@labs.fujitsu.com>
Reply-To: tsuchiya@labs.fujitsu.com
Organization: Fujitsu Labs
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tsuchiya@labs.fujitsu.com
CC: Bryan Whitehead <driver@jpl.nasa.gov>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: filesystem bug?
References: <3FDD7DFD.7020306@labs.fujitsu.com> <1071582242.5462.1.camel@sisko.scot.redhat.com> <3FDF7BE0.205@jpl.nasa.gov> <3FDF95EB.2080903@labs.fujitsu.com>
In-Reply-To: <3FDF95EB.2080903@labs.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tsuchiya Yoshihiro wrote:

> Especially with Ext2 reproducing is easy, it happens in a few hours 
> with my script.
> With Ext3, in a day if you are lucky.
>
> Now I am trying 2.4.23 from kernel.org with ext3, and 2.6.0-test11 
> from kernel.org with ext3.
> So far, it's been a about a day, they are runing nicely. Let's see 
> what happens.
>
> Following is the failed combination:
> Redhat9 with 2.4.20-8 ext2 and ext3
> Redhat9 with 2.4.20-19.9 ext2 and ext3
> Redhat9 with 2.4.20-24.9 ext2

I forgot to mention that I had been testing 2.4.20 from kernel.org 
also.... And it failed now!

As you see below, /mnt/foo/ad/mozilla was gone. ad/mozilla had been used 
to compare
with dir*/mozilla and it is basically read-only and will never be 
removed by the script.
/mnt/foo/ae is ok and ae/mozilla is of cource there.

It had been almost 2days scince the test started, and the test was 58-th 
turn.
It had run on ext2 filesystem, and the kernel was downloaded from 
kernel.org.

I had seen the same problem--I mean read-only mozilla directory going 
away--
on ext3 on redhat kernel 2.4.20-19.9.

[root@dell04 tsuchiya]# ls /mnt/foo/ad
dir0   dir14  dir2   dir25  dir30  dir36  dir41  dir47  dir52  dir58
dir1   dir15  dir20  dir26  dir31  dir37  dir42  dir48  dir53  dir6
dir10  dir16  dir21  dir27  dir32  dir38  dir43  dir49  dir54  dir7
dir11  dir17  dir22  dir28  dir33  dir39  dir44  dir5   dir55  dir8
dir12  dir18  dir23  dir29  dir34  dir4   dir45  dir50  dir56  dir9
dir13  dir19  dir24  dir3   dir35  dir40  dir46  dir51  dir57
[root@dell04 tsuchiya]# ls /mnt/foo/ae
dir0   dir14  dir2   dir25  dir30  dir36  dir41  dir47  dir52  dir58
dir1   dir15  dir20  dir26  dir31  dir37  dir42  dir48  dir53  dir6
dir10  dir16  dir21  dir27  dir32  dir38  dir43  dir49  dir54  dir7
dir11  dir17  dir22  dir28  dir33  dir39  dir44  dir5   dir55  dir8
dir12  dir18  dir23  dir29  dir34  dir4   dir45  dir50  dir56  dir9
dir13  dir19  dir24  dir3   dir35  dir40  dir46  dir51  dir57  mozilla

Yoshi
--
Yoshihiro Tsuchiya



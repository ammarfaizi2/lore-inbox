Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262546AbVEMUel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbVEMUel (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 16:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbVEMUeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 16:34:22 -0400
Received: from mail.tmr.com ([64.65.253.246]:46301 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S262536AbVEMUXD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 16:23:03 -0400
Message-ID: <42850FC7.7010603@tmr.com>
Date: Fri, 13 May 2005 16:36:23 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
CC: "Srinivas G." <srinivasg@esntechnologies.co.in>,
       linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: Y2K-like bug to hit Linux computers! - Info of the day
References: <4EE0CBA31942E547B99B3D4BFAB348114BED13@mail.esn.co.in> <200505131522.32403.vda@ilport.com.ua> <Pine.LNX.4.61.0505130825310.4428@chaos.analogic.com> <Pine.LNX.4.61.0505130837390.4781@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0505130837390.4781@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> 
> It would be good if the doom-sayers actually tried before then lied.....
> 
> Just in case anybody wants to try it:
> 
> int main()
> {
>     int x = 0x7fffff00;
>     stime(&x);
> }
> 
> Script started on Mon 18 Jan 2038 10:12:32 PM EST
> [root@chaos root]# while true ; do date ; sleep 1 ; done
> Mon Jan 18 22:12:44 EST 2038
> Mon Jan 18 22:12:45 EST 2038
> Mon Jan 18 22:12:46 EST 2038
> Mon Jan 18 22:12:47 EST 2038
> Mon Jan 18 22:12:48 EST 2038
> [SNIPPED...]
> Mon Jan 18 22:14:01 EST 2038
> Mon Jan 18 22:14:02 EST 2038
> Mon Jan 18 22:14:03 EST 2038
> Mon Jan 18 22:14:04 EST 2038
> Mon Jan 18 22:14:05 EST 2038
> Mon Jan 18 22:14:06 EST 2038
> Mon Jan 18 22:14:07 EST 2038
> Fri Dec 13 15:46:09 EST 1901
                 ^^^^^ are UTC and GMT that far apart? Leap seconds? WTF?
> Fri Dec 13 15:46:10 EST 1901
> Fri Dec 13 15:46:11 EST 1901
> Fri Dec 13 15:46:12 EST 1901
> Fri Dec 13 15:46:13 EST 1901
> Fri Dec 13 15:46:14 EST 1901
> Fri Dec 13 15:46:15 EST 1901
> Fri Dec 13 15:46:16 EST 1901
> Fri Dec 13 15:46:17 EST 1901
> Fri Dec 13 15:46:18 EST 1901
> Fri Dec 13 15:46:19 EST 1901
> 
> [root@chaos root]# exit
> 
> Script done on Fri 13 Dec 1901 03:46:44 PM EST
> 
> As you can see, the machine still runs. There was a little
> hickup in the 'sleep 1' it slept more than a second.
> 
> Remember to `rdate` your computer before you do any serious
> work. The file-dates correctly show the new, before Unix, time and
> date.

Good point. Given current firewalls, I wouldn't be surprised if rdate 
fails and ntpdate is needed, or at least resetting the system clock from HW.

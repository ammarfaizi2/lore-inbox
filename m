Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbUCYOw7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 09:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263177AbUCYOw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 09:52:59 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:34743 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S263171AbUCYOwy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 09:52:54 -0500
Message-ID: <4062F244.7050008@free.fr>
Date: Thu, 25 Mar 2004 15:52:52 +0100
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, trelane@digitasaru.net
Subject: Re: 2.6.5-rc2-mm2 still does not boot but it progress : seems to
 be console font related
References: <406172C9.8000706@free.fr> <20040324095236.68cb1deb.akpm@osdl.org>
In-Reply-To: <20040324095236.68cb1deb.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Are you using devfs?  If so, please try the below patch (I don't see why,
> but..)

Yes. I use devfs.

Sorry for the delay, I'm back, with a new , more silent, and working 
fan, after a brutal powerdown due to fan failure and CPU overheat... As 
my PC is thre years old, it takes time to find compatible fans...

The machine that boots again but unfortunately I had to hardwire a BIOS 
CMOS reset and therefore BIOS settings have been restored to factory 
default values. I hopefully restored back then to what they where but 
cannot guaranty it 100%.

I applied the patch and get the deadlock is gone *BUT* due to BIOS 
default changed (including one that may impact performance (PIC read 
caching, PCU byte grouping, ...), and the fact that it was probably a 
deadlock due to a window that may have disappearred if I did not restore 
correctly the settings, I cannot gurante that it is the fix that fixed 
the problem.

I hope that Joseph Pingenot that had the same problem can confirm it.
I erased the mail were he was confirming the symptom and I have its 
address no more. Could you double check with him that the patch indeed 
fix the problem?

Thanks for chasing the bug anyway,

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr




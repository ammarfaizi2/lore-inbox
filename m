Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbVLANAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbVLANAf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 08:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbVLANAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 08:00:35 -0500
Received: from networks.syneticon.net ([213.239.212.131]:49089 "EHLO
	mail2.syneticon.net") by vger.kernel.org with ESMTP id S932220AbVLANAe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 08:00:34 -0500
Message-ID: <438EF3E5.5080709@wpkg.org>
Date: Thu, 01 Dec 2005 14:00:21 +0100
From: Tomasz Chmielewski <mangoo@wpkg.org>
User-Agent: Mozilla Thunderbird 1.0.7-3mdk (X11/20051015)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: loadavg always equal or above 1.00 - how to explain?
References: <438EE515.1080001@wpkg.org> <1133440871.2853.36.camel@laptopd505.fenrus.org>
In-Reply-To: <1133440871.2853.36.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven schrieb:
> On Thu, 2005-12-01 at 12:57 +0100, Tomasz Chmielewski wrote:
> 
>>1.00 1.10 1.06 1/65 782
>>
>>This server is barely used, and as I remember, loadavg was always
>>close 
>>to 0.00 on that system.
> 
> 
> remember that load is the sum of running/runable processes and processes
> in D state (waiting for IO generally, but not always). I'm pretty sure
> your load comes from one of the later...
> 
> ps ought to tell you which one it is... (if not, an 
> "echo t > /proc/sysrq-trigger" will dump the kernel state including the
> offending process, and will also tell us where exactly that process is)

Wohoo, you're great, that was it:

root     29547  0.0  0.3   7516   996 ?        D    Nov25   0:00 CROND
root     29548  0.0  0.3   7516   996 ?        Ss   Nov25   0:00 CROND

I stopped it, and loadavg is back to 0.

Now I have to figure out what CROND was doing...

Does ps always show processes in D state in CAPITAL letters?

After cron restart it is "crond", as usual.


-- 
Tomek
http://wpkg.org
WPKG - software deployment and upgrades with Samba

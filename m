Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262621AbVF2Qri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262621AbVF2Qri (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 12:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbVF2Qo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 12:44:29 -0400
Received: from mx2.tippett.com ([64.81.248.66]:18275 "EHLO mx2.tippett.com")
	by vger.kernel.org with ESMTP id S262611AbVF2Qj4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 12:39:56 -0400
Message-ID: <42C2CE98.3020504@tippett.com>
Date: Wed, 29 Jun 2005 09:38:48 -0700
From: Christian Rice <xian@tippett.com>
Reply-To: xian@tippett.com
Organization: Tippett Studio
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: "'Nathan Scott'" <nathans@sgi.com>, linux-xfs@oss.sgi.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: XFS corruption during power-blackout
References: <200506290453.HAA14576@raad.intranet>
In-Reply-To: <200506290453.HAA14576@raad.intranet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (mx2.tippett.com [192.168.12.2]); Wed, 29 Jun 2005 09:21:47 -0700 (PDT)
X-Spam-Score: -4.532 () ALL_TRUSTED,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:

>Hi Nathan,
>You wrote: {
>On Tue, Jun 28, 2005 at 12:08:05PM +0300, Al Boldi wrote:
>  
>
>>True now, not so around 2.4.20 when XFS was rock-solid. I think they 
>>tried to improve on performance and broke something. I wish they would 
>>fix that because it forced me back to ext3, as in consistency over 
>>performance any time.
>>    
>>
>
>Can you provide any details...
>}
>
>Specifically, in 2.4.20 I did an acid test:
>Spawn 10 cp -a on some big dir like /usr.
>Let it run for a few seconds, then pull the plug.
>Don't reset-button, reset is different then pulling the plug.
>Don't poweroff-button, poweroff is different then pulling the plug.
>On reboot diff the dirs spawned.
>
>What I found were 4 things in the dest dir:
>1. Missing Dirs,Files. That's OK.
>2. Files of size 0. That's acceptable.
>3. Corrupted Files. That's unacceptable.
>4. Corrupted Files with original fingerprint. That's ABSOLUTELY
>unacceptable.
>
>Ext3 performed best with minimal files of size 0.
>XFS was second  with more files of size 0.
>Reiser,JFS was worst with corruptions.
>
>When XFS was added into the vanilla-Kernel it caused corruptions like Reiser
>and JFS, which forced me back to Ext3.
>
>
>
>  
>
Pardon me if I haven't seen the whole thread.

Do you have hard drive write cache turned off or, if it's a raid card, a 
battery backup on the write cache?  That makes a big difference when 
operators begin doing things like pulling plugs and hitting reset.

Again, no offense, just one of those "have you taken it out of the box, 
plugged it in and turned it on" kind of questions.

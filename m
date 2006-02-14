Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030334AbWBNAiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030334AbWBNAiL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 19:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030338AbWBNAiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 19:38:11 -0500
Received: from drugphish.ch ([69.55.226.176]:64986 "EHLO www.drugphish.ch")
	by vger.kernel.org with ESMTP id S1030334AbWBNAiK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 19:38:10 -0500
Message-ID: <43F12597.2000006@drugphish.ch>
Date: Tue, 14 Feb 2006 01:34:31 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
Cc: Yoss <bartek@milc.com.pl>, linux-kernel@vger.kernel.org
Subject: Re: Memory leak in 2.4.33-pre1?
References: <20060213214651.GA27844@milc.com.pl> <20060214000529.GJ11380@w.ods.org>
In-Reply-To: <20060214000529.GJ11380@w.ods.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>So there is missing about ~300MB.
>>If anyone wants to have more detailed info feel free to ask.
>  
> You don't have to worry. Simply check /proc/slabinfo, you'll see plenty
> of memory used by dentry_cache and inode_cache and that's expected. This

Well, 300M dentry and inode is quite a lot for a system that has been up 
at most for 6 days.

> memory will be reclaimed when needed (for instance by calls to malloc()).

slabtop -s c -o | head -20

would be interesting to see, otherwise I agree with Willy, as always ;).

Cheers,
Roberto Nibali, ratz
-- 
echo 
'[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq' | dc

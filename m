Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWCAMws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWCAMws (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 07:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWCAMws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 07:52:48 -0500
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:29568 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750937AbWCAMwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 07:52:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Vck0wRFnynPksIlhpHe0MFKs/xq7qDi0cE9Km5oWL70gXP7FHZBc4mK9G0N34I3olj9P2qljwgDS3GTqayRbt8zwE7vLySqPA6uBAyE7PXiX3+rZZw7EYwei+GA+zItMkVp+iOmYE2Q4blfipvCQwsWlIoow0ADLdkM/wcOEHtg=  ;
Message-ID: <44059915.3010800@yahoo.com.au>
Date: Wed, 01 Mar 2006 23:52:37 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: jiffies_64 vs. jiffies
References: <20060301.144442.118975101.nemoto@toshiba-tops.co.jp> <20060301.210541.30439818.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20060301.210541.30439818.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atsushi Nemoto wrote:

> @@ -924,8 +924,7 @@ static inline void update_times(void)
>  
>  void do_timer(struct pt_regs *regs)
>  {
> -	jiffies_64++;
> -	update_times();
> +	update_times(++jiffies_64);
>  	softlockup_tick(regs);
>  }
>  

jiffies_64 is not volatile so you should not have to obfuscate
the code like this.

-- 
Send instant messages to your online friends http://au.messenger.yahoo.com 

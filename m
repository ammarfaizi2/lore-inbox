Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754665AbWKRO0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754665AbWKRO0U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 09:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754709AbWKRO0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 09:26:20 -0500
Received: from smtpout04-04.prod.mesa1.secureserver.net ([64.202.165.199]:49605
	"HELO smtpout04-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S1754665AbWKRO0U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 09:26:20 -0500
Message-ID: <455F180A.9080301@seclark.us>
Date: Sat, 18 Nov 2006 09:26:18 -0500
From: Stephen Clark <Stephen.Clark@seclark.us>
Reply-To: Stephen.Clark@seclark.us
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ismail Donmez <ismail@pardus.org.tr>
CC: jketreno@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: IEEE80211 and IPW3945
References: <20061118102056.GA4492@gimli> <200611181449.53483.ismail@pardus.org.tr>
In-Reply-To: <200611181449.53483.ismail@pardus.org.tr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ismail Donmez wrote:

>18 Kas 2006 Cts 12:20 tarihinde, Martin Lorenz şunları yazmıştı: 
>  
>
>>Dear James,
>>
>>I just had some issues when trying to compile ieee80211 1.2.15 together
>>with ipw3945 1.1.2 on the latest kernel tree
>>
>>attached are two patches I had to create to work around it
>>I guess they are self-explanatory :-)
>>    
>>
>
>I wonder when will ieee80211 tree will be merged to mainline, according to 
>some posts[1] its needed for some devices.
>
>[1] http://www.ubuntuforums.org/showthread.php?t=156930
>
>/ismail
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

On Mon, 13 Nov 2006 08:42:55 -0500 Stephen Clark wrote:


>> can someone tell me why I have to replace the 803.11 stack that is 
>> already in
>> linux 2.6.19 rc5 with the stack at sf.
>  
>

You don't have to.
The one in .19-rc5 is new enough (the one in .18 too AFAIK)

I have successfully run ipw3945 with FC6 using the ieee80211 stack from the kernel
I just had to compile with:
 make IEEE80211_API=2 EXTRA_CFLAGS=-DIEEE80211_API_VERSION=2

and ln autoconf.h to config.h

HTH,
steve



-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)




Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135339AbREHUsl>; Tue, 8 May 2001 16:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135328AbREHUsc>; Tue, 8 May 2001 16:48:32 -0400
Received: from fe100.worldonline.dk ([212.54.64.211]:55304 "HELO
	fe100.worldonline.dk") by vger.kernel.org with SMTP
	id <S135344AbREHUsW>; Tue, 8 May 2001 16:48:22 -0400
Message-ID: <3AF9A3EA.8080209@eisenstein.dk>
Date: Wed, 09 May 2001 22:09:14 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-mosix i586; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en, da
MIME-Version: 1.0
To: Ronald Bultje <rbultje@ronald.bitfreak.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Patch to improve readability of sock_rcvlowat() - comments wanted...
In-Reply-To: <3AF72A19.7030009@eisenstein.dk> <20010507235541.Q4514@tux.bitfreak.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ronald Bultje wrote:

> On 2001.05.08 01:04:57 +0200 Jesper Juhl wrote:
> 
>> static inline int sock_rcvlowat(struct sock *sk, int waitall, int len)
>> {
>>          int r = len;
>>          if (!waitall)
>>                  r = min(sk->rcvlowat, len);
>>          return max(1,r);
>> }
>> 
> 
> 
> return max(1, waitall ? len : min(sk->rcvlowat, len));
> 
> Although I doubt this is more readable... :-)
> 

IMO your version is less readable than the 4-liner above, and the code 
it generates is a lot bigger than both the original and the proposed 
replacement - but thank you for the suggestion...

- Jesper Juhl - juhl@eisenstein.dk


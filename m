Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265350AbRGEWua>; Thu, 5 Jul 2001 18:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265367AbRGEWuV>; Thu, 5 Jul 2001 18:50:21 -0400
Received: from sncgw.nai.com ([161.69.248.229]:16883 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S265350AbRGEWuD>;
	Thu, 5 Jul 2001 18:50:03 -0400
Message-ID: <XFMail.20010705155318.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <9515.994372983@redhat.com>
Date: Thu, 05 Jul 2001 15:53:18 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: linux/macros.h(new) and linux/list.h(mod) ...
Cc: linux-kernel@vger.kernel.org, Daniel Phillips <phillips@bonn-fries.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05-Jul-2001 David Woodhouse wrote:
> 
> phillips@bonn-fries.net said:
>> This program prints garbage:
>>      #define min(x,y) ({ typeof((x)) _x = (x); typeof((y)) _y = (y);
>>      #(_x>_y)?_y:_x; })
>>              int main (void) { 
>>              int _x = 3, _y = 4; 
>>              printf("%i\n", min(_x, _y)); 
>>              return 0; 
>>      } 
> 
> Life's a bitch.
> cf. get_user(__ret_gu, __val_gu); (on i386)
> 
> Time to invent a gcc extension which gives us unique names? :)

Something like ::(x) to move up one level the name resolution for example.



- Davide


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264578AbUEMWBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264578AbUEMWBv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 18:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265163AbUEMWBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 18:01:51 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:22934 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S264578AbUEMWBt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 18:01:49 -0400
Message-ID: <40A3EB84.8020405@free.fr>
Date: Thu, 13 May 2004 23:41:24 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040501
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm2 : Hitting Num Lock kills keyboard
References: <40A3C951.9000501@free.fr>	<40A3CF97.5000405@free.fr> <20040513125750.59434a33.akpm@osdl.org>
In-Reply-To: <20040513125750.59434a33.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Eric Valette <eric.valette@free.fr> wrote:
> 
>>Eric Valette wrote:
>>
>>>Andrew,
>>>
>>>I tested 2.6.6-mm2 this afternoon and twice I totally lost my keyboard. 
>>
>>Well, I can reproduce it at will : I just need to hit the numlock key 
>>and keyboard is frozen.
> 
> 
> Could you please do
> 
> 	patch -p1 -R -i bk-input.patch

Yes it fixes it. Thanks for the quick answer and sorry for the delay...

In the thread, other have reported the same problem with the Caps Lock 
key. Both keys have at least three things in common :
	1) They do no echo any character,
	2) They modify the interpretation of the next key pressed (change a 
keyboard status),
	3) They light up a led on the keyboard,

As the input handling logic has changed (if I remember correctly), the 
new logic (locking, signaling)  must be wrong for those keys...

Thanks for the quic way to reverse the faulty patch. Can now peacefully 
wait for the real fixe :-)

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr




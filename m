Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTGXLCY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 07:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbTGXLCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 07:02:24 -0400
Received: from [61.211.239.235] ([61.211.239.235]:34781 "EHLO
	maison.kyo-ko.org") by vger.kernel.org with ESMTP id S262123AbTGXLCV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 07:02:21 -0400
Message-ID: <3F1FBFFC.9050305@da-cha.org>
Date: Thu, 24 Jul 2003 20:16:12 +0900
From: Hiroshi Miura <miura@da-cha.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ja-JP; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: ja, zh, en, zh-CN, zh-TW, ko
MIME-Version: 1.0
To: hirofumi@mail.parknet.co.jp
Cc: ndiamond@wta.att.ne.jp, linux-kernel@vger.kernel.org, vojtech@suse.cz,
       junkio@cox.net
Subject: Re: Japanese keyboards broken in 2.6
References: <018401c35059$2bb8f940$4fee4ca5@DIAMONDLX60>	<20030722172903.A12240@pclin040.win.tue.nl> <87k7a9z7ly.fsf@devron.myhome.or.jp>
In-Reply-To: <87k7a9z7ly.fsf@devron.myhome.or.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can use Japanese keyboard.
I DO recompile console-tools with header file in linux-2.5/2.6.
Because of NR_KEYS change, as Ogawa-san said,
in 2.4 NR_KEYS=128, in 2.6 NR_KEYS= 0x200

When recompile, some tools fails compile on linux-2.6,
but 'loadkeys' compiles nicely.

Instantly, user can set new keymap to use a recompiled loadkey command.

BTW, Ogawa-san's patch is needed?
I think this fix should made on user-mode tool 'console-tools'.
As same as module-init-tools, console-tools should detect kernel version
and switch type of interface, doesn't it?

Junkio's patch looks reasonable.

OGAWA Hirofumi wrote:
> Andries Brouwer <aebr@win.tue.nl> writes:
> 
> 
>>On Tue, Jul 22, 2003 at 10:56:33PM +0900, Norman Diamond wrote:
>>
>>
>>>On a Japanese PS/2 keyboard
>>
>>I did not read your long message but stopped after the above words.
>>Sorry if this is not an answer (ask again).
>>
>>For 2.6.0t1 it helps to add the line
>>
>>  keycode 183 = backslash bar
>>
>>to your keymap.
> 
> 
> I remembered this problem. At 2.4.x kbd tools use "#define NR_KEYS 128".
> So, we can't set >= 128.
> 
> Currently NR_KEYS is 0x200 (KEY_MAX+1). We can't only recompile
> because ->kb_index (struct kbentry) type using "unsigned char".
> 
> What do you think the following patch? (it may be needed to cleanup or
> rewrite)
> 
> Thanks.

Hiroshi Miura
miura@da-cha.org


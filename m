Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751530AbWCDSor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbWCDSor (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 13:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbWCDSor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 13:44:47 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:16001 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751530AbWCDSor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 13:44:47 -0500
Date: Sat, 4 Mar 2006 19:44:01 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Nick Warne <nick@linicks.net>
cc: Adrian Bunk <bunk@stusta.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>,
       Willy Tarreau <willy@w.ods.org>
Subject: Re: [2.4 patch] Corrected faulty syntax in drivers/input/Config.in
In-Reply-To: <7c3341450603031226o55f6c77ah@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0603041943170.29991@yvahk01.tjqt.qr>
References: <20060303180100.GV9295@stusta.de> <7c3341450603031226o55f6c77ah@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> If statement in drivers/input/Config.in for "make xconfig" corrected.
>>
>> Signed-off-by: Stefan-W. Hahn <stefan.hahn@s-hahn.de>
>> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>>
>> --- a/drivers/input/Config.in
>> +++ b/drivers/input/Config.in
>> @@ -8,7 +8,7 @@ comment 'Input core support'
>>  tristate 'Input core support' CONFIG_INPUT
>>  dep_tristate '  Keyboard support' CONFIG_INPUT_KEYBDEV $CONFIG_INPUT
>>
>> -if [ "$CONFIG_INPUT_KEYBDEV" == "n" ]; then
>> +if [ "$CONFIG_INPUT_KEYBDEV" = "n" ]; then
>>         bool '  Use dummy keyboard driver' CONFIG_DUMMY_KEYB $CONFIG_INPUT
>>  fi

If this is sh compatible code, then == is just as valid -- if xconfig 
breaks then, then xconfig is broken, not the file.


Jan Engelhardt
-- 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbUDDIJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 04:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbUDDIJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 04:09:28 -0400
Received: from A8bb8.a.pppool.de ([213.6.139.184]:9344 "EHLO susi.maya.org")
	by vger.kernel.org with ESMTP id S262244AbUDDIJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 04:09:27 -0400
Message-ID: <406FC226.5090802@A8bb8.a.pppool.de>
Date: Sun, 04 Apr 2004 10:07:02 +0200
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040212
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4 : 100% CPU use on EIDE disk operarion, VIA chipset
References: <fa.g80v5s8.b2ofhi@ifi.uio.no> <fa.idlmgtf.1pluljl@ifi.uio.no>
In-Reply-To: <fa.idlmgtf.1pluljl@ifi.uio.no>
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> Andreas Hartmann wrote:
>> This is what top says during cp of 512MB-file:
>> Cpu(s):  2.0% us,  8.3% sy,  0.0% ni,  0.0% id, 89.0% wa,  0.7% hi,  
>> 0.0% si
>> 
>> New is "wa", what probably means "wait". This value is very high as long 
>> as the HD is writing or reading datas:
>> 
>> cp dummy /dev/null
>> produces this top-line:
>> Cpu(s):  3.0% us,  5.3% sy,  0.0% ni,  0.0% id, 91.0% wa,  0.7% hi,  
>> 0.0% si
> 
> Yes "wa" is not intuitive, some other operating systems use "wio" for 
> "wait i/o" time. As noted in the other thread, you can try the deadline 
> elevator or increased readahead for your load.

If the processor and the kernel could do other things during wa, like
compiling e.g., it would be no problem. But it seems to be, that this is
not possible. Or did I oversee something?


Regards,
Andreas Hartmann


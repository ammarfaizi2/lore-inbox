Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbVDRFly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbVDRFly (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 01:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVDRFly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 01:41:54 -0400
Received: from tama5.ecl.ntt.co.jp ([129.60.39.102]:61852 "EHLO
	tama5.ecl.ntt.co.jp") by vger.kernel.org with ESMTP id S261681AbVDRFlv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 01:41:51 -0400
Message-ID: <42634898.5050702@lab.ntt.co.jp>
Date: Mon, 18 Apr 2005 14:41:44 +0900
From: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Daniel Jacobowitz <dan@debian.org>, Chris Wedgwood <cw@f00f.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
References: <4263275A.2020405@lab.ntt.co.jp>  <20050418040718.GA31163@taniwha.stupidest.org>  <4263356D.9080007@lab.ntt.co.jp>  <20050418044223.GB15002@nevyn.them.org> <1113800136.355.1.camel@localhost.localdomain> <Pine.LNX.4.58.0504172159120.28447@bigblue.dev.mdolabs.com>
In-Reply-To: <Pine.LNX.4.58.0504172159120.28447@bigblue.dev.mdolabs.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:

>On Mon, 2005-04-18 at 00:42 -0400, Daniel Jacobowitz wrote:
>
>  
>
>>On Mon, Apr 18, 2005 at 01:19:57PM +0900, Takashi Ikebe wrote:
>>    
>>
>>>GDB based approach seems not fit to our requirements. GDB(ptrace) based 
>>>functions are basically need to be done when target process is stopping.
>>>In addition to that current PTRACE_PEEK/POKE* allows us to copy only a 
>>>*word* size...
>>>      
>>>
>>While true, this is easily fixable. 
>>    
>>
>
>Indeed, look at the systr_pmem_read() and systr_pmem_write() functions:
>
>http://www.xmailserver.org/sysctr.html
>
>  
>
systr_pmem_read() and systr_pmem_write() just calls ptrace PTRACE_PEEKTEXT/DATA repeatedly....
In this case we need to *stop* target process whenever patch modules is loading....
It cause target process availability worse.

-- 
Takashi Ikebe
NTT Network Service Systems Laboratories
9-11, Midori-Cho 3-Chome Musashino-Shi,
Tokyo 180-8585 Japan
Tel : +81 422 59 4246, Fax : +81 422 60 4012
e-mail : ikebe.takashi@lab.ntt.co.jp



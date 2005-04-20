Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVDTESv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVDTESv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 00:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVDTESv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 00:18:51 -0400
Received: from tama5.ecl.ntt.co.jp ([129.60.39.102]:48081 "EHLO
	tama5.ecl.ntt.co.jp") by vger.kernel.org with ESMTP id S261320AbVDTESs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 00:18:48 -0400
Message-ID: <4265D80F.6030007@lab.ntt.co.jp>
Date: Wed, 20 Apr 2005 13:18:23 +0900
From: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Rik van Riel <riel@redhat.com>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
References: <42636285.9060405@lab.ntt.co.jp> <20050418075635.GB644@taniwha.stupidest.org> <20050418021609.07f6ec16.pj@sgi.com> <20050418092505.GA2206@taniwha.stupidest.org> <Pine.LNX.4.61.0504180726320.3232@chimarrao.boston.redhat.com> <4263AD94.0@lab.ntt.co.jp> <Pine.LNX.4.61.0504181001470.8456@chimarrao.boston.redhat.com> <42646983.4020908@lab.ntt.co.jp> <20050419042720.GA15123@taniwha.stupidest.org> <426494FD.6020307@lab.ntt.co.jp> <20050419055254.GA15895@taniwha.stupidest.org>
In-Reply-To: <20050419055254.GA15895@taniwha.stupidest.org>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Chris Wedgwood wrote:

>
>  
>
>>On live patching, you never need to use shared memory, just prepare
>>fixed code, and just compile it as shared ibject, that's all. pretty
>>easy and fast to replace the functions.
>>    
>>
>
>it requires magic like a compiler and knowledge of the original
>application.
>  
>
Well, Live patching is just a patch, so I think the developer of patch
should know the original source code well.

>if the application was written sensibly someone without access to the
>application code could change this live taking over the previous
>applications state even more easily --- and the code would be more
>straightforward.  so i still fail to see why this is needed.
>  
>
Well, as you said some application can do that, but some application can
not continue service with your suggestion.
please think about the process which use connection type communication
such as TCP(it's only example) between users and server. During status
copy, all the session between users and server are disconnected... can
not save the exiting service at all.
It's one example, but similar problems may occurs whenever processed use
the resources which are mainly controlled by kernel.

-- 
Takashi Ikebe
NTT Network Service Systems Laboratories
9-11, Midori-Cho 3-Chome Musashino-Shi,
Tokyo 180-8585 Japan
Tel : +81 422 59 4246, Fax : +81 422 60 4012
e-mail : ikebe.takashi@lab.ntt.co.jp



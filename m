Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWIEMkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWIEMkk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 08:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWIEMkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 08:40:40 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:61866 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S932200AbWIEMkj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 08:40:39 -0400
Message-ID: <44FD71C6.20006@student.ltu.se>
Date: Tue, 05 Sep 2006 14:47:02 +0200
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
CC: akpm@osdl.org, xfs-masters@oss.sgi.com, xfs@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc4-mm3 2/2] fs/xfs: Converting into generic boolean
References: <44F833C9.1000208@student.ltu.se> <20060904150241.I3335706@wobbly.melbourne.sgi.com> <44FBFEE9.4010201@student.ltu.se> <20060905130557.A3334712@wobbly.melbourne.sgi.com>
In-Reply-To: <20060905130557.A3334712@wobbly.melbourne.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott wrote:

>On Mon, Sep 04, 2006 at 12:24:41PM +0200, Richard Knutsson wrote:
>  
>
>>Nathan Scott wrote:
>>    
>>
>>>Hmm, so your bool is better than the next guys bool[ean[_t]]? :)
>>>      
>>>
>>Well yes, because it is not "mine". ;)
>>It is, after all, just a typedef of the C99 _Bool-type.
>>    
>>
>
>Hmm, one is really no better than the other IMO.
>  
>
IMO the _Bool is better because that lets the compiler do its magic.

>>>I took the earlier patch and completed it, switching over to int
>>>use in place of boolean_t in the few places it used - I'll merge
>>>that at some point, when its had enough testing.
>>>
>>>      
>>>
>>Is that set in stone? Or is there a chance to (in my opinion) improve 
>>the readability, by setting the variables to their real type.
>>    
>>
>
>Nothings completely "set in stone" ... anyone can (and does) offer
>their own opinion.  The opinion of people who a/ read and write XFS
>code alot and b/ test their changes, is alot more interesting than
>the opinion of those who don't, however.
>  
>
Of course! :) No critisism intended.

Just the notion: "your" guys was the ones to make those to boolean(_t), 
and now you seem to want to patch them away because I tried to make them 
more general.

>In reality, from an XFS point of view, there are so few uses of the
>local boolean_t and so little value from it, that it really is just
>not worth getting involved in the pending bool code churn IMO (I see
>72 definitions of TRUE and FALSE in a recent mainline tree, so you
>have your work cut out for you...).
>  
>
So, is the:
B_FALSE -> false
B_TRUE -> true
ok by you?

>"int needflush;" is just as readable (some would argue moreso) as
>"bool needflush;" and thats pretty much the level of use in XFS -
>  
>
How are you sure "needflush" is, for example, not a counter?

>and we're using the "int" form in so many other places anyway...
>but, I'll see what the rest of the XFS folks think and take it from
>there.
>  
>
Ok

>cheers.
>  
>
cu


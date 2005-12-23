Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030474AbVLWJxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030474AbVLWJxg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 04:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030476AbVLWJxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 04:53:36 -0500
Received: from uproxy.gmail.com ([66.249.92.193]:5388 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030474AbVLWJxg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 04:53:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:user-agent:x-accept-language:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=sKCLFCIXvt8IxVuKhpAGG1/FjxSqfrzIlvTYpiHFQup6CtExntD1wbGIZszAO/IBZai3gUgy2/0nhPkKqnHZWB0kxIE69l1Jfxx5fNHgSK55qZNx6pt/qAi/SVUhSsN4J0usfrKVWxjTXbESGlP9TPfAcv+k4F5Giy0byCaf1pE=
Message-ID: <43ABC8B2.7020904@gmail.com>
Date: Fri, 23 Dec 2005 11:51:46 +0200
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Wagner <daw@cs.berkeley.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Question] LinuxThreads, setuid - Is there user mode hook?
References: <200512222312.jBMNCj96018554@taverner.CS.Berkeley.EDU>
In-Reply-To: <200512222312.jBMNCj96018554@taverner.CS.Berkeley.EDU>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Wagner wrote:
> In article <43AACA82.5050305@gmail.com> you write:
> 
>>I am writing a provider that uses pthreads. The main program 
>>does not aware that the provider is using threads and it is 
>>not multithreaded.
>>
>>After initialization the program setuid to nobody, the 
>>problem is that my threads remains in root id.
> 
> 
> Mixing threads and setuid programs seems like a really bad idea.
> This is especially true if you have to ask about it -- which means
> that you don't know enough to write such a program safely (please
> don't take offense).
> 

I know that!
And I am aware of the (Linux implementation) implications...

I don't think you read my question in deep...
I offer a provider (Shared library), and I must deal with 
this edge condition where the main program setuid.

In Linux every thread is a process so only the main thread 
is setuided.

I need to catch this even in my shared library and setuid my 
threads as well, since Linux pthreads implementation does 
not take care of this.

Since I am not writing the main program and since I cannot 
force the main programmer to behave any differently, I must 
handle this internally.

Do you know a way to be notified when the process setuid?

Best Regards,
Alon Bar-Lev.

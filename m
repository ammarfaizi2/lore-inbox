Return-Path: <linux-kernel-owner+w=401wt.eu-S932922AbWLSUCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932922AbWLSUCA (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 15:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932917AbWLSUCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 15:02:00 -0500
Received: from wx-out-0506.google.com ([66.249.82.236]:55859 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932922AbWLSUB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 15:01:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UpW2BBN2AQrTPLTReG1Z8vzrAAQBnZvbq6143sY+4ISC/hJnXDg5Ntp3XTLOLJcEDLYMibyJZYiTFAFdwSD7g0f0GTunD2lLdPD54MdefwKXnNx+W5XqZsnjEM72N/QNMIk/C3czNN5EKi8nxmCpkXZ8+81wGkW26QMW7VjlmqI=
Message-ID: <5a4c581d0612191201l1e7c9693t169f4ac548411578@mail.gmail.com>
Date: Tue, 19 Dec 2006 21:01:59 +0100
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "art@usfltd.com" <art@usfltd.com>
Subject: Re: 2.6.20-rc1-git compilation error drivers/connector/connector.c:138: error: ?struct work_struct? has no member named ?management?
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <20061219101424.yjwfjsykcbs0o0wc@69.222.0.225>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061219101424.yjwfjsykcbs0o0wc@69.222.0.225>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/06, art@usfltd.com <art@usfltd.com> wrote:
> to: linux-kernel@vger.kernel.org
> cc: torvalds@osdl.org
>
>
> 2.6.20-rc1-git compilation error drivers/connector/connector.c:138:
> error: ?struct work_struct? has no member named ?management?
>
> $ date
> Tue Dec 19 10:12:17 CST 2006
> $ git pull
> Already up-to-date.
> $ make -j 8
>    CHK     include/linux/version.h
>    CHK     include/linux/utsrelease.h
>    CHK     include/linux/compile.h
>    CC      drivers/connector/connector.o
> drivers/connector/connector.c: In function ?cn_call_callback?:
> drivers/connector/connector.c:138: error: ?struct work_struct? has no
> member named ?management?
> drivers/connector/connector.c:138: error: ?struct work_struct? has no
> member named ?management?
> make[2]: *** [drivers/connector/connector.o] Error 1
> make[1]: *** [drivers/connector] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [drivers] Error 2
> make: *** Waiting for unfinished jobs....

Already reported twice, and fixed by Al Viro's patch:

http://www.ussg.iu.edu/hypermail/linux/kernel/0612.2/0197.html

 (though -rc1-git6 doesn't yet have the fix)

--alessandro

"...when I get it, I _get_ it"

     (Lara Eidemiller)

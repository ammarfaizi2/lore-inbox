Return-Path: <linux-kernel-owner+w=401wt.eu-S1753935AbWLRMjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753935AbWLRMjl (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 07:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753936AbWLRMjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 07:39:40 -0500
Received: from wx-out-0506.google.com ([66.249.82.228]:61889 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753935AbWLRMjk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 07:39:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X1/d6YTB42Rd3iZiYVM50P+AM38qIDrcicx3yO3dI/EpQC4UOaiti8gGRPVe6oaRx+VH0RzjXR28TIDVpc3AA/b17WzrZWm1R45tSPCzi1peH3CQzfmlkhA7txwingOoK8NLVOXmW/pycQrEzkxGVlp+LUtx9+gktD0LwPsRgf8=
Message-ID: <652016d30612180439y6cd12089l115e4ef6ce2e59fe@mail.gmail.com>
Date: Mon, 18 Dec 2006 18:24:39 +0545
From: "Manish Regmi" <regmi.manish@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: Linux disk performance.
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
In-Reply-To: <1166431020.3365.931.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <652016d30612172007m58d7a828q378863121ebdc535@mail.gmail.com>
	 <1166431020.3365.931.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/06, Arjan van de Ven <arjan@infradead.org> wrote:
> if you want truely really smooth writes you'll have to work for it,
> since "bumpy" writes tend to be better for performance so naturally the
> kernel will favor those.
>
> to get smooth writes you'll need to do a threaded setup where you do an
> msync/fdatasync/sync_file_range on a frequent-but-regular interval from
> a thread. Be aware that this is quite likely to give you lower maximum
> performance than the batching behavior though.
>

Thanks...

But isn't O_DIRECT supposed to bypass buffering in Kernel?
Doesn't it directly write to disk?
I tried to put fdatasync() at regular intervals but there was no
visible effect.

-- 
---------------------------------------------------------------
regards
Manish Regmi

---------------------------------------------------------------
UNIX without a C Compiler is like eating Spaghetti with your mouth
sewn shut. It just doesn't make sense.

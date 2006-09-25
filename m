Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbWIYKew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWIYKew (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 06:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWIYKew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 06:34:52 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:24970 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751075AbWIYKev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 06:34:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CfhxmuohFHdN29m4IA14upiSECfyALOljFnNiOaL6abmOIzZiJdHUthIMadz6re5ONJCtE6J0TcykHeX4hnCaCPnL1Z8N5ev8CNN0+Sg3KyPkHCBGvJMDHCJnep76fXpLsClAHa8WCYP3EodROx1tBCPJ21dbQrakP2y54lCscI=
Message-ID: <9a8748490609250334r5d104adex3599c52b2358aba3@mail.gmail.com>
Date: Mon, 25 Sep 2006 12:34:50 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Muli Ben-Yehuda" <muli@il.ibm.com>
Subject: Re: mainline aic94xx firmware woes
Cc: "James Bottomley" <James.Bottomley@steeleye.com>,
       linux-scsi <linux-scsi@vger.kernel.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060925101124.GH6374@rhun.haifa.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060925101124.GH6374@rhun.haifa.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/06, Muli Ben-Yehuda <muli@il.ibm.com> wrote:
> Hi,
>
> The recently merged aic94xx in mainline requires external firmware
> support. This, in turn, necessitates an initrd/initramfs environment
> that includes firmware support to load the firmware. Will a patch to
> optionally include the firmware inline in the kernel and thus not
> having to use an initramfs be acceptable?
>
It's not my call, but I'd say that if the firmware is not GPL and the
source for that firmware is not available then the answer will be NO
(which would also be my personal opinion btw).

> Also, aic94xx does not compile unless FW_LOADER is set in .config due
> to missing 'request_firmware'. What's the right thing to do here -
> aic94xx selecting it, depending on it, or FW_LOADER providing empty
> request_firmware() in case it's compiled out (the last one violates
> the principle of least surprise IMHO).
>
I'd say aic94xx depending on it with a note in the help text that it
requires it. But that's just my personal opinion.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

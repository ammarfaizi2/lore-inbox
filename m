Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbWKUWC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWKUWC1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 17:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031233AbWKUWC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 17:02:26 -0500
Received: from nz-out-0102.google.com ([64.233.162.197]:63114 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1031166AbWKUWCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 17:02:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J+AHoAqsfEIByvawHwuFwHPbIOlA3Q65DtNcIxGpnwonrbkJAzpTwfTku6FhKdw2Fe8+U4/A08b4B7rRQ+Z/WGpQ+pDnP/l6Tvyv9oRCPXdG2MAdXsYQq37zYp6UfDBJFJOhEazX9fqlcZeQcVpshXlgj9CzURANOEqCytGPotI=
Message-ID: <9a8748490611211402xdc2822fqbc95a77fe54d49b1@mail.gmail.com>
Date: Tue, 21 Nov 2006 23:02:23 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: chatz@melbourne.sgi.com
Subject: Re: 2.6.19-rc6 : Spontaneous reboots, stack overflows - seems to implicate xfs, scsi, networking, SMP
Cc: LKML <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com, netdev@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <45637566.5020802@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200611211027.41971.jesper.juhl@gmail.com>
	 <45637566.5020802@melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/06, David Chatterton <chatz@melbourne.sgi.com> wrote:
> Jesper,
>
> In the short term, the best workaround is to use 8K stacks.

Yeah, that's what I'm currently doing and the box seems more stable
(at least it has not crashed yet, but with 4K stacks it usually would
have by now).

> We do not see stack
> overflow problems with NFS + XFS + volume managers + disk devices.
>
Could the size of my devices be part of the cause? some of the logical
volumes I have mounted are multiple TB in size?


> Audits have been done in the past and will again be done in the future to try to
> identify areas where XFS could use less stack space by reducing/avoid large
> local variables. Reducing the code path is far more difficult.
>
I realize that fixing the problem may be difficult. I just wanted to
make sure that people were informed that there is an actual problem
and provide as much info as possible so that perhaps in the future it
can be fixed... :)
I'm reading through the XFS code myself at the moment and I'll be sure
to submit patches if I spot something that could help reduce stack
usage.


> There is active discussion about reducing inlining:
> http://bugzilla.kernel.org/show_bug.cgi?id=7364
>

Thanks, I'll check that out.


> I can't speak for the scsi stack usage.
>
> Thanks for traces, I've captured this information.
>
You are welcome. If you want/need more traces then I've got ~2.1G
worth of traces that you can have :)


Thank you for your reply.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

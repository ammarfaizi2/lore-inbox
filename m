Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbWH1TYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWH1TYy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 15:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWH1TYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 15:24:54 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:25250 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751379AbWH1TYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 15:24:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TnIbZeNAFbLiwsC+PD8teIp5t2Zxy64Hlv3OyPE0uH69VyCEL4oA4PdN9y+RP3jz7t9A8hwJaY+1ax1tfkD7wuL4OvnBfQIbOBKZM4EH2hNQ9cS/Z2TkCQF6qqDGn6YAWt0VLWxAj4sYGDiS/jCV/AbDd6GlLsaZPcUWtyQaHMk=
Message-ID: <9e0cf0bf0608281224r28a6af47tc689757488e93c5a@mail.gmail.com>
Date: Mon, 28 Aug 2006 22:24:51 +0300
From: "Alon Bar-Lev" <alon.barlev@gmail.com>
To: "Matt Domsch" <Matt_Domsch@dell.com>
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit (ping)
Cc: "H. Peter Anvin" <hpa@zytor.com>, "Andi Kleen" <ak@suse.de>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johninsd@san.rr.com
In-Reply-To: <20060828184637.GD13464@lists.us.dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <445B5524.2090001@gmail.com> <44F1F356.5030105@zytor.com>
	 <200608272254.13871.ak@suse.de> <44F21122.3030505@zytor.com>
	 <44F286E8.1000100@gmail.com> <44F2902B.5050304@gmail.com>
	 <44F29BCD.3080408@zytor.com>
	 <9e0cf0bf0608280519y7a9afcb9od29494b9cacb8852@mail.gmail.com>
	 <44F335C8.7020108@zytor.com>
	 <20060828184637.GD13464@lists.us.dell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/06, Matt Domsch <Matt_Domsch@dell.com> wrote:
> No reason.  I was just trying to be careful, not leaving data in the
> upper bits of those registers going uninitialized.  If we know they're
> not being used ever, then it's not a problem.  But I don't think
> that's the source of the command line size concern, is it?

Since the cmd_line_ptr is 32bit, we can load the lower 16bits into si,
ignoring the upper 16bits, or we can use esi for all references.
I think using esi for all references is cleaner...

Best Regards,
Alon Bar-Lev.

Return-Path: <linux-kernel-owner+w=401wt.eu-S1161175AbXAHIAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161175AbXAHIAn (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 03:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161181AbXAHIAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 03:00:43 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:44761 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161175AbXAHIAm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 03:00:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=CXoSipQ54x+p0Iaj5LEuMey2rIdPY33ubXupoOxEELYcmIyrQc7+eiR+EC522ZBFfVR0H3ypIgEOyBGVbW2VMzwubJGCTyzw/G9rSAt8L1dTjRUxVP3OYCtzTXUvsNXeKQlQBtcewMAFO8iLuDxRQssYMjoY+O9bDmeSVOR71cw=
Message-ID: <84144f020701080000v460a9f3aja9570e72fa457934@mail.gmail.com>
Date: Mon, 8 Jan 2007 10:00:41 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Hua Zhong" <hzhong@gmail.com>
Subject: Re: [PATCH] include/linux/slab.h: new KFREE() macro.
Cc: "Amit Choudhary" <amit2030@yahoo.com>,
       "Christoph Hellwig" <hch@infradead.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <000501c732f9$7e3386a0$0200a8c0@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <108973.65122.qm@web55613.mail.re4.yahoo.com>
	 <000501c732f9$7e3386a0$0200a8c0@nuitysystems.com>
X-Google-Sender-Auth: 7470ea35d845cbe2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/07, Hua Zhong <hzhong@gmail.com> wrote:
> > And as I explained, it can result in longer code too. So, why
> > keep this value around. Why not re-initialize it to NULL.
>
> Because initialization increases code size.

And it also effectively blocks the slab debugging code from doing its
job detecting double-frees.

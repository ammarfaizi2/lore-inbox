Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262180AbVHAANC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbVHAANC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 20:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVHAANC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 20:13:02 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:39832 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262180AbVHAANA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 20:13:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FZFJNv+NNishzLUPWJIxBxTpzm4eVggy4jedThQ2GhZq1B6XNhFYf9Msgoz7IZjPu66bs9z7KNwhagGZ3fX+TA351Zzgx8NRXQG2zgCpSmjAitYRocYj8A6qUSq3bzjWqDBxf5cw3KcrmVbizfPNRxaT7SIv11QhYRBjVZYWPB0=
Message-ID: <21d7e99705073117121241159a@mail.gmail.com>
Date: Mon, 1 Aug 2005 10:12:58 +1000
From: Dave Airlie <airlied@gmail.com>
To: Roland McGrath <roland@redhat.com>
Subject: Re: Fw: sigwait() breaks when straced
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050801000120.1D00F180EC0@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050730170049.6df9e39f.akpm@osdl.org>
	 <20050801000120.1D00F180EC0@magilla.sf.frob.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> However, there is in fact no bug here.  The test program is just wrong.
> sigwait returns zero or an error number, as POSIX specifies.  Conversely,
> sigtimedwait and sigwaitinfo either return 0 or set errno and return -1.
> It is odd that the interfaces of related functions differ in this way,
> but they do.

The someone should fix the manpage, it explicitly says
"The sigwait function never returns an error."

Which is clearly wrong if it can return EINTR...

Dave.

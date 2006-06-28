Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbWF1QnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWF1QnZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 12:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWF1QnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:43:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:48625 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751389AbWF1QnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:43:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aZ4L2GOOmfv89KHhdnyKX6lIJetvMx/9PlseSp0Nx1273v9nfMbGrBsxcu8LxjvSeB62JUd5nYKutq9odQJJu6e9YYDsZuJYxE4dRYmaad1lKu5SPZarDGv7rq8gygBetN+HuY5ZNdsBAdHbBb0A4KjtNkZaOoGV2E4WYQp1Z/k=
Message-ID: <a36005b50606280943l54138e80tbda08e1607136792@mail.gmail.com>
Date: Wed, 28 Jun 2006 09:43:22 -0700
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: make PROT_WRITE imply PROT_READ
Cc: "Arjan van de Ven" <arjan@infradead.org>,
       "Jason Baron" <jbaron@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060627095632.GA22666@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <fa.PuMM6IwflUYh1MWILO9rb6z4fvY@ifi.uio.no>
	 <449B42B3.6010908@shaw.ca>
	 <Pine.LNX.4.64.0606230934360.24102@dhcp83-5.boston.redhat.com>
	 <1151071581.3204.14.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0606231002150.24102@dhcp83-5.boston.redhat.com>
	 <1151072280.3204.17.camel@laptopd505.fenrus.org>
	 <a36005b50606241145q4d1dd17dg85f80e07fb582cdb@mail.gmail.com>
	 <20060627095632.GA22666@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/06, Pavel Machek <pavel@ucw.cz> wrote:
> Usability for "normal" C applications is probably not too high... so
> why not work around it in glibc, if at all?

Because it wouldn't affect all b inaries.  Existing code could still
cause the problem.  Also, there are other callers of the syscalls
(direct, other libcs, etc).  The only reliable way to get rid of this
problem is to enforce it in the kernel.  Since the kernel cannot make
sense of this setting in all situations it is IMO even necessary since
you really don't want to have anything as unstable as this code.

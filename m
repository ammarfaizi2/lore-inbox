Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbWDUOHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWDUOHV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 10:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWDUOHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 10:07:20 -0400
Received: from nproxy.gmail.com ([64.233.182.184]:55182 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932316AbWDUOHT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 10:07:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U3ycSz4NiVwBqS4u3RVEKNDZyAQW58TxtlUz12RAHsF2y27EebUPqrXa8NbWni7ygYw5IRxOwWP6n3U8mm3HWZ1kq0Uw1pL6p+PCYul82PmbuORoFWou7pfGnxdonBlZXLup2am+0mLJgJ0HDxz3qynogLNmJSqGeBYeVnqKcOw=
Message-ID: <7115951b0604210707q2113dd65tda67e24c07d6c0ad@mail.gmail.com>
Date: Fri, 21 Apr 2006 21:07:17 +0700
From: "Dmitry Fedorov" <dm.fedorov@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: kfree(NULL)
In-Reply-To: <200604210656.40158.vernux@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200604210703.k3L73VZ6019794@dwalker1.mvista.com>
	 <Pine.LNX.4.64.0604210322110.21429@d.namei>
	 <20060421015412.49a554fa.akpm@osdl.org>
	 <200604210656.40158.vernux@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/4/21, Vernon Mauery <vernux@us.ibm.com>:

> Maybe kfree should really be a wrapper around __kfree which does the real
> work.  Then kfree could be a inlined function or a #define that does the NULL
> pointer check.

NULL pointer check in kfree saves lot of small code fragments in callers.
It is one of many reasons why kfree does it.
Making kfree inline wrapper eliminates this save.

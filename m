Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262000AbUL0XoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbUL0XoK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 18:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbUL0XoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 18:44:10 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:46232 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262000AbUL0XoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 18:44:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=tGz2OT+eM8QDRXM6dHDFi9/dmoNRj+7UeEvBWrBJ1AUU7F2CvGo6q62hcYpZc1D0yZUm1MfFqihYj35eG4sglKXNmOFUZxi1c89GrxRF+Fhef4w527S8ba2fw93gOmZqxCGsuPN9I+vLjJX0f7X3XJ13UjXCU1UxjTdK8pfneug=
Message-ID: <a36005b5041227154457b24773@mail.gmail.com>
Date: Mon, 27 Dec 2004 15:44:07 -0800
From: Ulrich Drepper <drepper@gmail.com>
Reply-To: Ulrich Drepper <drepper@gmail.com>
To: Brian Gerst <bgerst@didntduck.org>
Subject: Re: 2.4, 2.6, i686/athlon and LDT's
Cc: Arjan van de Ven <arjan@infradead.org>,
       Tymm Twillman <ttwillman@penguincomputing.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <41D076D9.30404@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41D0668B.206@penguincomputing.com>
	 <1104178937.4187.16.camel@laptopd505.fenrus.org>
	 <41D076D9.30404@didntduck.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2004 15:55:53 -0500, Brian Gerst <bgerst@didntduck.org> wrote:
> Using the LDT isn't inherently slower, since the cpu caches the segment
> descriptor regardless of if it came from the GDT or LDT.

Not using LDT's on 2.4 kernel other than RHEL3's means to have a
different ABI.  This is the /lib/libpthread.so.0 RH is shipping which
simply cannot be used in some/many situations since there is no
"thread register".  This means the programmer is not able to select
size and/or location of the stacks.  Interfaces like
pthread_attr_setstack() simply won't work at all.

So, do't confuse people with "does anyone have comparison information
w/threads using
LDT's and without (performance, protection, etc)?".  That's comparing
apples and oranges.

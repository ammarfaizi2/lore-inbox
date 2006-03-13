Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbWCMQ3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWCMQ3Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 11:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWCMQ3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 11:29:16 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:47309 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751279AbWCMQ3Q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 11:29:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p/leyeO3PJvT0JGLB0etkqyMaPYiPEPfqFK78MMAe7a0w39cKqPCqkU9coF9hpfBHwOZoKFfo4+RoBESV0Qawmrfhm9gnigFLu0CsmSJw1Eee9llSsefsTIj6Lv4+Vw/sohNaLK7nP4oEbsKfImxrHV8v8PfLBBJv7Rap1y24jU=
Message-ID: <a36005b50603130829h2e6c05f8je8c27155bdff0330@mail.gmail.com>
Date: Mon, 13 Mar 2006 08:29:15 -0800
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Jakub Jelinek" <jakub@redhat.com>
Subject: Re: [PATCH] Fix sigaltstack corruption among cloned threads
Cc: "GOTO Masanori" <gotom@sanori.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060313153022.GP20301@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <81ek16loay.wl%gotom@sanori.org>
	 <a36005b50603130716x4cc5306ex2f8ecf012ea052d1@mail.gmail.com>
	 <20060313153022.GP20301@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/06, Jakub Jelinek <jakub@redhat.com> wrote:
> Because vfork also sets CLONE_VM and vfork isn't supposed to reset
> alternate stack setting.

I'd say this is rather an oversight than a real requirement (we fixed
quite a few such problems in the POSIX spec of vfork) but it should be
as safe as any other solution.  So, I'm OK with the extended CLONE_VM
test.

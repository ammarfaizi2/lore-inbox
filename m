Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030539AbVJGSFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030539AbVJGSFm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 14:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030542AbVJGSFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 14:05:42 -0400
Received: from xproxy.gmail.com ([66.249.82.203]:48165 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030539AbVJGSFl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 14:05:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l3rBJ6PDXlHZeCaxwFOPMn5CMqsD1znsF4txPBXeM3KaNriyO0yxoOurYtWv3tNHOuJ44OlMZLVnFGGd+LzHr8Qjz8CQLzsHqZNR8NaB+mM334nQq4zBPozA7FXZGVZ07kaaihwbR0C3hnGIlV6TEmKIp5T8+uGj7A9DKR2Zx14=
Message-ID: <ed5aea430510071105y5f76b5b6qe4d92c829fc3262e@mail.gmail.com>
Date: Fri, 7 Oct 2005 11:05:40 -0700
From: David Mosberger-Tang <David.Mosberger@acm.org>
Reply-To: David Mosberger-Tang <David.Mosberger@acm.org>
To: "H. J. Lu" <hjl@lucon.org>
Subject: Re: PATCH: Fix 2.6 kernel for the new ia64 assembler
Cc: linux ia64 kernel <linux-ia64@vger.kernel.org>,
       linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051007180119.GA11645@lucon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051007180119.GA11645@lucon.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks fine to me.

  --david

On 10/7/05, H. J. Lu <hjl@lucon.org> wrote:
> The new ia64 assembler uses slot 1 for the offset of a long (2-slot)
> instruction and the old assembler uses slot 2. The 2.6 kernel assumes
> slot 2 and won't boot when the new assembler is used:
>
> http://sources.redhat.com/bugzilla/show_bug.cgi?id=1433
>
> This patch will work with either slot 1 or 2.
>
>
> H.J.
>
>
>


--
Mosberger Consulting LLC, voice/fax: 510-744-9372,
http://www.mosberger-consulting.com/
35706 Runckel Lane, Fremont, CA 94536

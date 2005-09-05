Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbVIEG3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbVIEG3a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 02:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbVIEG33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 02:29:29 -0400
Received: from nproxy.gmail.com ([64.233.182.199]:34282 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932220AbVIEG33 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 02:29:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VNU6KrYsnw35At30ALwpkq1PUvZTyy6+TN0+9Xvdwc+5HfYb1BNtv+uaIn9Bgr7t1FsCXwn2kYxWVfNF1Id7AxjH0ZtnjFHpW42QP345vpIWibIHX90SgMrZL3TCo6GkTW+VW7UqbzRjhIQQdsm6le57cUywzlRjnNMW9TlJD0Y=
Message-ID: <84144f0205090423294d7ee873@mail.gmail.com>
Date: Mon, 5 Sep 2005 09:29:25 +0300
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: RFC: i386: kill !4KSTACKS
Cc: Sean <seanlkml@sympatico.ca>, Alex Davis <alex14641@yahoo.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050905060405.GA16784@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <35547.10.10.10.10.1125892279.squirrel@linux1>
	 <20050905040311.29623.qmail@web50204.mail.yahoo.com>
	 <50570.10.10.10.10.1125893576.squirrel@linux1>
	 <20050905043613.GD30279@alpha.home.local>
	 <46230.10.10.10.10.1125895623.squirrel@linux1>
	 <20050905050108.GA16596@alpha.home.local>
	 <59215.10.10.10.10.1125898289.squirrel@linux1>
	 <20050905060405.GA16784@alpha.home.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/05, Willy Tarreau <willy@w.ods.org> wrote:
> Except that someone has to maintain the patch, because with the speed the
> kernel is changing, a patch against 2.6.14 will not work on 2.6.15.

Indeed. It has to be maintained in tree as well and I don't see any
justification for making mainline care about !4KB_STACKS just for the
sake of ndiswrapper. While I appreciate that ndiswrapper is useful for
some people, it should IMHO be maintained as an out-of-tree patch
(stack size included).

                                   Pekka

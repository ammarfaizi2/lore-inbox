Return-Path: <linux-kernel-owner+w=401wt.eu-S965312AbXATQrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965312AbXATQrf (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 11:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965310AbXATQrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 11:47:35 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:22741 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965312AbXATQre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 11:47:34 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=nNystXINjgky1TIelzolNX/C9BdIDgwRKMRbIXO1z9pxz8EglRfxTcnRng0XWjE0Wg3jWLevitluowHHIqrGnc174Kb9WHXoLHmktuQ6hpf0Na6eMnxzBnbAQMmfB7wdrpoKJKCPaIEClp5q+Z9rIrmFYLyLKgf4o4bQmV6NqIM=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: "Nate Diller" <nate.diller@gmail.com>
Subject: Re: O_DIRECT question
Date: Sat, 20 Jan 2007 17:45:40 +0100
User-Agent: KMail/1.8.2
Cc: "Andrew Morton" <akpm@osdl.org>, andersen@codepoet.org,
       "Linus Torvalds" <torvalds@osdl.org>,
       "Michael Tokarev" <mjt@tls.msk.ru>,
       "Chris Mason" <chris.mason@oracle.com>, "dean gaudet" <dean@arctic.org>,
       Viktor <vvp01@inbox.ru>, Aubrey <aubreylee@gmail.com>,
       "Hua Zhong" <hzhong@gmail.com>, "Hugh Dickins" <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com
References: <Pine.LNX.4.64.0701110750520.3594@woody.osdl.org> <20070112144748.6c4bb19e.akpm@osdl.org> <5c49b0ed0701140111p6fd2d60at7ec246738b887a73@mail.gmail.com>
In-Reply-To: <5c49b0ed0701140111p6fd2d60at7ec246738b887a73@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701201745.40656.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 14 January 2007 10:11, Nate Diller wrote:
> On 1/12/07, Andrew Morton <akpm@osdl.org> wrote:
> Most applications don't get the kind of performance analysis that
> Digeo was doing, and even then, it's rather lucky that we caught that.
>  So I personally think it'd be best for libc or something to simulate
> the O_STREAM behavior if you ask for it.  That would simplify things
> for the most common case, and have the side benefit of reducing the
> amount of extra code an application would need in order to take
> advantage of that feature.

Sounds like you are saying that making O_DIRECT really mean
O_STREAM will work for everybody (including db people,
except that they will moan a lot about "it isn't _real_ O_DIRECT!!!
Linux suxxx"). I don't care about that.
--
vda

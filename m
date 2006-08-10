Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbWHJSbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWHJSbt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 14:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWHJSbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 14:31:49 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:30633 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751452AbWHJSbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 14:31:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k1Ddznqh6ZPjRaB4uFOhh98fmf1hVNGuhdtzBo7SoqPNgT+iricW9hubhuRc0iywEGe0EKkV+3kIKrTvM0yOUrvNy9u2LSwB7zUvlz56o+BdFCqxumc+AeNYPf5rxif3hogxJ2sSnKrJh/Zkxsyi8oFillOGJ7MI06JxcBfJj6A=
Message-ID: <5c49b0ed0608101131h55f1505eo44b78603e2e8d3c2@mail.gmail.com>
Date: Thu, 10 Aug 2006 11:31:46 -0700
From: "Nate Diller" <nate.diller@gmail.com>
To: "Hans Reiser" <reiser@namesys.com>
Subject: Re: partial reiser4 review comments
Cc: "Christoph Hellwig" <hch@infradead.org>,
       "Alexander Zarochentsev" <zam@namesys.com>,
       "Andrew Morton" <akpm@osdl.org>, reiserfs-dev@namesys.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <44D9A86F.3010304@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060803001741.4ee9ff72.akpm@osdl.org>
	 <20060803142644.GC20405@infradead.org>
	 <200608061838.35004.zam@namesys.com>
	 <20060809085946.GA6177@infradead.org> <44D9A86F.3010304@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/06, Hans Reiser <reiser@namesys.com> wrote:
> Christoph Hellwig wrote:
>
> > I must admit that standalone code snipplet doesn't really tell me a lot.
> >
> >Do you mean the possibility to pass around a filesystem-defined structure
> >to multiple allocator calls?  I'm pretty sure can add that, I though it
> >would be useful multiple times in the past but always found ways around
> >it.
> >
> >
> >
> Assuming I understand your discussion, I see two ways to go, one is to
> pass around fs specific state and continue to call into the FS many
> times, and the other is to instead provide the fs with helper functions
> that accomplish readahead calculation, page allocation, etc., and let
> the FS keep its state naturally without having to preserve it in some fs
> defined structure.  The second approach would be cleaner code design,
> that would also ease cross-os porting of filesystems, in my view.

the second approach is the one i was heading towards with my
unfinished a_ops patches.  *please* won't someone pay me to do that
work...

NATE

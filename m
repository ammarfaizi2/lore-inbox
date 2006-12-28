Return-Path: <linux-kernel-owner+w=401wt.eu-S964944AbWL1F6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbWL1F6F (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 00:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbWL1F6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 00:58:05 -0500
Received: from nz-out-0506.google.com ([64.233.162.231]:6248 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964944AbWL1F6E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 00:58:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dIK6uAIPC4gFOX+pYmGOAanG1333pS84zq+BVuLuR+T6F2aFQTKp4dz8G10jbD39KGgmW6M7sgNBL/Mq0XSmR6vjLg6he3+TQ75dBSvG/IsWQXHvnn+pVUdba1Od9xKnbnPrULCGG00QHpJO41DuG2MPehZKADipMKJfLw0WFXM=
Message-ID: <97a0a9ac0612272158h72f75a2bt22eccddcbbb2d9a9@mail.gmail.com>
Date: Wed, 27 Dec 2006 22:58:02 -0700
From: "Gordon Farquharson" <gordonfarquharson@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one
Cc: "David Miller" <davem@davemloft.net>, ranma@tdiedrich.de, tbm@cyrius.com,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>, andrei.popa@i-neo.ro,
       "Andrew Morton" <akpm@osdl.org>, hugh@veritas.com,
       nickpiggin@yahoo.com.au, arjan@infradead.org,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0612272120180.4473@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061226.205518.63739038.davem@davemloft.net>
	 <Pine.LNX.4.64.0612271601430.4473@woody.osdl.org>
	 <Pine.LNX.4.64.0612271636540.4473@woody.osdl.org>
	 <20061227.165246.112622837.davem@davemloft.net>
	 <Pine.LNX.4.64.0612271835410.4473@woody.osdl.org>
	 <97a0a9ac0612272032uf5358c4qf12bf183f97309a6@mail.gmail.com>
	 <Pine.LNX.4.64.0612272039411.4473@woody.osdl.org>
	 <97a0a9ac0612272115g4cce1f08n3c3c8498a6076bd5@mail.gmail.com>
	 <Pine.LNX.4.64.0612272120180.4473@woody.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/06, Linus Torvalds <torvalds@osdl.org> wrote:

> That's just 400kB!
>
> There's no way you should see corruption with that kind of value. It
> should all stay solidly in the cache.

100kB and 200kB files always succeed on the ARM system. 400kB and
larger always seem to fail.

Does the following help interpret the results on ARM at all ?

$ free
             total       used       free     shared    buffers     cached
Mem:         30000      23620       6380          0        808      15676
-/+ buffers/cache:       7136      22864
Swap:        88316       3664      84652

Gordon

-- 
Gordon Farquharson

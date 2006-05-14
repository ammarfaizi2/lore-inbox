Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbWENOxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbWENOxS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 10:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWENOxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 10:53:18 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:43867 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751434AbWENOxS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 10:53:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=tjsrBP5O8b7yQKmU/Mjy6qHTevpJnkVxxdou05GPZOQXjpCxPmK3eKX0k8ves9GHssOXoQ0PgRDU2IxyN5RsDCUozxUjgP9l6E4jvuPuMqbEkfLUClXgk4XTROkZ47Pz8+AONksAqs7eLDFCLZydnIl61nXkz5O6ZukCgrCRkvk=
Message-ID: <84144f020605140753t67f10c3fmf754581aa74b39f5@mail.gmail.com>
Date: Sun, 14 May 2006 17:53:17 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2.6.17-rc4 1/6] Base support for kmemleak
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060513160541.8848.2113.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060513155757.8848.11980.stgit@localhost.localdomain>
	 <20060513160541.8848.2113.stgit@localhost.localdomain>
X-Google-Sender-Auth: e9775794929d9989
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> This patch adds the base support for the kernel memory leak detector. It
> traces the memory allocation/freeing in a way similar to the Boehm's
> conservative garbage collector, the difference being that the orphan
> pointers are not freed but only shown in /proc/memleak. Enabling this
> feature would introduce an overhead to memory allocations.

Hmm. How much is the overhead anyway? I am guessing lots so can we
reasonably expect anyone to run such kernel? Why isn't DEBUG_SLAB_LEAK
enough for us?

                                               Pekka

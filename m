Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261944AbUKPKjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbUKPKjf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 05:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbUKPKjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 05:39:35 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:56910 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261948AbUKPKf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 05:35:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=fm+UO7QdrxqnUccqotJ3Mbi9XTrDHDYQPOqYmmhehvX+FN07xNAoaqjzpR9xcat2UIYz5wWZL6gyUn13LW3s9KMcvgBXOntOPyZ3Uv1utUo9wNY8jtI+hwCxcVRtztH7XaCOwrGmDmzrNm2O5ePWOaln/wU8eswimZnTD5TXNzI=
Message-ID: <84144f020411160235616c529b@mail.gmail.com>
Date: Tue, 16 Nov 2004 12:35:57 +0200
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu>
	 <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org>
	 <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu>
	 <84144f0204111602136a9bbded@mail.gmail.com>
	 <E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 16 Nov 2004 11:20:22 +0100, Miklos Szeredi <miklos@szeredi.hu> wrote:
> >    - Breaks if CONFIG_PROC_FS is not enabled.
> 
> Yes.  Would a device node be better?  Perhaps.  This way there's no
> need to allocate a major/minor for a device.

...or fix your Kconfig to select procfs. :)

On Tue, 16 Nov 2004 11:20:22 +0100, Miklos Szeredi <miklos@szeredi.hu> wrote: 
> >    - Explicit casts are not needed when converting void pointers
> > (found in various places).
> 
> But they don't hurt either.  At least I can be sure to assign the
> right kind of pointer.

Hmm? The conversion is guaranteed by the standard which makes them
redundant. And redundancy does hurt maintainability. The have been
patches to get rid of the existing casts so please don't introduce new
ones.

                             Pekka

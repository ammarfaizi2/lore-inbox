Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132195AbQKZDly>; Sat, 25 Nov 2000 22:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132208AbQKZDlo>; Sat, 25 Nov 2000 22:41:44 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:2764 "EHLO
        orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
        id <S132195AbQKZDli>; Sat, 25 Nov 2000 22:41:38 -0500
From: James A Sutherland <jas88@cam.ac.uk>
To: Tim Waugh <twaugh@redhat.com>
Subject: Re: [PATCH] removal of "static foo = 0"
Date: Sun, 26 Nov 2000 03:10:42 +0000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: Andries Brouwer <aeb@veritas.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20001125211939.A6883@veritas.com> <0011252259430A.11866@dax.joh.cam.ac.uk> <20001125235511.A16662@redhat.com>
In-Reply-To: <20001125235511.A16662@redhat.com>
MIME-Version: 1.0
Message-Id: <00112603125100.15051@dax.joh.cam.ac.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2000, Tim Waugh wrote:
> 
> On Sat, Nov 25, 2000 at 10:53:00PM +0000, James A Sutherland wrote:
> 
> > Which is silly. The variable is explicitly defined to be zero
> > anyway, whether you put this in your code or not.
> 
> Why doesn't the compiler just leave out explicit zeros from the
> 'initial data' segment then?  Seems like it ought to be tought to..

Good idea; unfortunately, it's probably too kernel-specific, so gcc may not
want to include this change. Also, the kernel is gcc version-specific; even if
this feature were automated in gcc now, it could take some time before the
kernel could safely be built under that version. Better to optimise the source
code to avoid the problem, rather than change the compiler to kludge around it.


James.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

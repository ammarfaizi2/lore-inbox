Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130865AbQK1WHt>; Tue, 28 Nov 2000 17:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131244AbQK1WHa>; Tue, 28 Nov 2000 17:07:30 -0500
Received: from hera.cwi.nl ([192.16.191.1]:40857 "EHLO hera.cwi.nl")
        by vger.kernel.org with ESMTP id <S131212AbQK1WHY>;
        Tue, 28 Nov 2000 17:07:24 -0500
Date: Tue, 28 Nov 2000 22:37:21 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Peter Cordes <peter@llama.nslug.ns.ca>, linux-kernel@vger.kernel.org
Subject: Re: access() says EROFS even for device files if /dev is mounted RO
Message-ID: <20001128223721.B11055@veritas.com>
In-Reply-To: <20001128010942.A9133@veritas.com> <200011281404.PAA24567@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200011281404.PAA24567@cave.bitwizard.nl>; from R.E.Wolff@BitWizard.nl on Tue, Nov 28, 2000 at 03:04:31PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2000 at 03:04:31PM +0100, Rogier Wolff wrote:

> Ok, so if you read the standard carefully you get a bogus result. 

Why bogus? Things could have been otherwise, but the important
part is that all Unices do things the same way.

> Question: Was it meant this way, or did someone just make a mistake
> (which happened to slip through and get approved into the standard)? 
> 
> I happen to think the second. 
> 
> - Is it desirable to have a write-open of a device on a read-only 
> fail? I don't think so. You can't open the initial console etc etc.

Nevertheless the standard requires this.

> - Is it desirable to have access (W_OK) and "open-for-write" return
> different results? I don't think so. 

Nevertheless there have never been systems where access and open
behaved identically. An easy example is given by directories
that have write access when a w bit is set, but return EISDIR
upon open-for-write.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

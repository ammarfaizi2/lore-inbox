Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312234AbSCRIIQ>; Mon, 18 Mar 2002 03:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312235AbSCRIII>; Mon, 18 Mar 2002 03:08:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49422 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312234AbSCRIHs>;
	Mon, 18 Mar 2002 03:07:48 -0500
Message-ID: <3C95A031.6070107@mandrakesoft.com>
Date: Mon, 18 Mar 2002 03:07:13 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: fadvise syscall?
In-Reply-To: <3C945635.4050101@mandrakesoft.com> <3C945A5A.9673053F@zip.com.au> <5.1.0.14.2.20020317131910.0522b490@pop.cus.cam.ac.uk> <3C959716.6040308@mandrakesoft.com> <3C959D55.14768770@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>posix_fadvise() looks to be a fine interface:
>

>We'll need to cheat a bit on the offset/len thing for NORMAL and
>SEQUENTIAL - just apply it to the whole file - we don't want to have to
>attach an arbitrary number of silly range objects to each file for this.
>(We already cheat a bit this way with msync).
>
yep

>Given this, I don't see a persuasive need to implement a non-standard
>interface.  It takes an off_t, so posix_fadvise64() is also needed.
>
agreed WRT non-standard.

Are we required to have both foo and foo64 variants?  If I had my 
druthers, I would just do the foo64 version.

>
>A 2.4 implementation could be done any time.  If anyone decides to
>do this, please let me know...
>


count me down as interested after my current project...  If someone else 
does it, more power to them...

    Jeff





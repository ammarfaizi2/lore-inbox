Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278320AbRJSHe0>; Fri, 19 Oct 2001 03:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278328AbRJSHeH>; Fri, 19 Oct 2001 03:34:07 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37194 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S278320AbRJSHd6>; Fri, 19 Oct 2001 03:33:58 -0400
To: "Brian C. Thomas" <bcthomas@nature.Berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: severe performance degradation on serverworks with high mem
In-Reply-To: <20011018125714.A360@nature.Berkeley.edu>
	<20011018144504.B134@nature.Berkeley.edu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Oct 2001 01:24:09 -0600
In-Reply-To: <20011018144504.B134@nature.Berkeley.edu>
Message-ID: <m1sncgnld2.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Brian C. Thomas" <bcthomas@nature.Berkeley.edu> writes:

> Hi
> 
> I don't know if this helps, but I seem to have stumbled onto a
> possible "fix" for this...
> 
> With 64GB high memory enabled in kernel 2.4.12-ac3, and mtrr turned
> on, I was able to see all 8GB RAM on my machine by using the old
> 'append="mem=8000M"' command in my lilo.conf file... AND WITH NO LOSS
> OF PERFORMANCE!
> 
> Does that help anyone with defining where this problem is coming from?

cat /proc/mtrr and see what the mtrrs look like.  It feels like there you
have a spot of RAM the BIOS doesn't cover with mtrrs.

Eric

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263417AbTDGMiZ (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 08:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263419AbTDGMiZ (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 08:38:25 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:54283 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263417AbTDGMiY (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 08:38:24 -0400
Date: Mon, 7 Apr 2003 13:49:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Paul Mackerras <paulus@au1.ibm.com>,
       Fabrice Bellard <fabrice.bellard@free.fr>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Qemu support for PPC
Message-ID: <20030407134954.A31558@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Paul Mackerras <paulus@au1.ibm.com>,
	Fabrice Bellard <fabrice.bellard@free.fr>,
	linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <20030407075622.A28354@infradead.org> <20030407083526.599562C04C@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030407083526.599562C04C@lists.samba.org>; from rusty@rustcorp.com.au on Mon, Apr 07, 2003 at 06:34:17PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 07, 2003 at 06:34:17PM +1000, Rusty Russell wrote:
> Oh good: a serious question.  Why don't we drop the personality field
> in struct task_struct and just use exec_domain?  Then the flags could
> be unfolded from the personality number, and placed in a "flags"
> element in struct exec_domain, the personality() macro would vanish,
> the set_personality() macro would vanish, and things would be
> generally clearer?

The personality number is exposed through sys_personality, so unfortunately
we can't get rid of it.  I still wonder what crack the person inviting this
scheme was smoking, though..

> That applies to any kernel mod, of course.  qemu is much more usable
> (ie. it's sanely packagable) with this functionality, ie. it's pretty
> much a requirement for increasing adoption.

You can just easily let it run in a chroot or separate namespace,
you just won't get second look semantics. (Personally I think that's
a benefit, but some people disagree with this).


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbUKPLU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbUKPLU5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 06:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbUKPLU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 06:20:57 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:25562 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261958AbUKPLUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 06:20:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=KU6FWbvNwEvzDU/XsltXIvzV/2bR9Dq2Mg+UDW6hHacJaILGA9F91kYyl8IqxGUCBL98wswta+KbY5cxDy2ivlMAVbihQ6vwyLwitSeGzf82kKl+5zwfFClqG4lhg6yn7/37gkEaOb6QXL+KrghGsT9cJIm88BCvaagP+pAqlno=
Message-ID: <84144f0204111603202f79f249@mail.gmail.com>
Date: Tue, 16 Nov 2004 13:20:38 +0200
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Simon Braunschmidt <braunschmidt@corscience.de>
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4199DDF2.5040700@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu>
	 <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org>
	 <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu>
	 <84144f0204111602136a9bbded@mail.gmail.com>
	 <E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu>
	 <84144f020411160235616c529b@mail.gmail.com>
	 <4199DDF2.5040700@corscience.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 16 Nov 2004 12:01:06 +0100, Simon Braunschmidt
<braunschmidt@corscience.de> wrote:
> And redundancy does hurt maintainability.
> 
> Naturally, it would be the other way around.
> Sure you can write all your code in binary, or even better compressed,
> but i wouldnt maintain those beasts ;-)

No, that is obfuscation and has nothing to do with this. The cast I
mentioned is _redudant_ because the common case is:

         struct foo * f = (struct foo *) priv; /* priv is void pointer */

And the cast gives you absolutely zero benefit in terms of
readability. For arithmetic types, you use casts to be explicit about
different conversions, but for void pointers there's only one
conversion which makes sense and that's what the standard guarantees.

On Tue, 16 Nov 2004 12:01:06 +0100, Simon Braunschmidt
<braunschmidt@corscience.de> wrote:
> I vote for explicit casts, makes code more readable.

I vote for the established kernel coding style.

                                Pekka

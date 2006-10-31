Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423837AbWJaToV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423837AbWJaToV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 14:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423839AbWJaToV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 14:44:21 -0500
Received: from wx-out-0506.google.com ([66.249.82.230]:37901 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1423837AbWJaToU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 14:44:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gjjRMVQrjRLzk1lBiwgmo2/0G4Pc3wHY25Y8rB4sBBipBKZ3Y45HSbkVvREL12P7YTS5MAJNLtDJhmhKjCpHKdJH0fBzkp7bQg4qbGPU/b9QZph5gLe01VcccVvCXYO8WVL6RcwOLEipQsZUui7yfgnu6XRlivi/J+OHGhg5KQ4=
Message-ID: <653402b90610311144y790c62e7ve1cd00389d42b9b5@mail.gmail.com>
Date: Tue, 31 Oct 2006 19:44:19 +0000
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Jiri Slaby" <jirislaby@gmail.com>
Subject: Re: mmaping a kernel buffer to user space
Cc: "Guillermo Marcus" <marcus@ti.uni-mannheim.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <45477EA8.8060809@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4547150F.8070408@ti.uni-mannheim.de> <4547733B.9040801@gmail.com>
	 <45477912.7070903@ti.uni-mannheim.de> <45477EA8.8060809@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/06, Jiri Slaby <jirislaby@gmail.com> wrote:
> Guillermo Marcus wrote:
> > Hi Jiri,
> >
> > The fact that it does not works with RAM is well documented in LDD3,
> > pages 430++. It says (and I tested) that remap_xxx_range does not work
> > in this case. They suggest a method using nopage, similar to the one I
> > implement.
>
> Could somebody confirm, that this still holds?
>

Hum, I also tried it some days ago and it didn't work for me, so I
read LDD3 and I found such explanation about such limitation of
remap_pfn_range(). I heard then that changed in 2.6.15 because of the
new flag; so I have had the same situation.

If it is possible to remap a kernel buffer to userspace with
remap_pfn_range, how should be done the right way?

> > I do not see why remap_xxx_range has the limitation, but it is there.
> > The question is then: can the limitation be removed, or can we implement
> > a new function that maps RAM all at once without the need for a nopage
> > implementation?
> >
> > In any case, here is the code.
>
> Hmm, interesting. I used remap_pfn_range for this purpose today and it worked (I
> double-checked this). I should probably do the rework :(.
>
> regards,
>

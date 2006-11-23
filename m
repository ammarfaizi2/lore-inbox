Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933754AbWKWOIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933754AbWKWOIH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 09:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933764AbWKWOIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 09:08:06 -0500
Received: from wx-out-0506.google.com ([66.249.82.230]:12012 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S933752AbWKWOID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 09:08:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GX6M1mOfPkpVtB6NVn+3y/tMnI1VbTrzQ3QhsL5IuZre0Ooy1W//IGvt+CipFalhAnX4hamAtLUkaqHlk7nwVlRAu4Kx9zJORa4aUnM5dPj4TQbyyzd7fxk4AQW/p0j2mFARXrlwacVLKYbsRmpUZKvqefoHrGgS6R1DwaLMTFQ=
Message-ID: <f36b08ee0611230608x297fe566mb5e97d5a180a7241@mail.gmail.com>
Date: Thu, 23 Nov 2006 16:08:02 +0200
From: "Yakov Lerner" <iler.ml@gmail.com>
To: "Xavier Bestel" <xavier.bestel@free.fr>,
       Kernel <linux-kernel@vger.kernel.org>
Subject: Re: coping with swap-exhaustion in 2.4.33-4
In-Reply-To: <1164285412.13074.131.camel@frg-rhel40-em64t-03>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <f36b08ee0611230430k9b2b625qc8d1b93031e09d14@mail.gmail.com>
	 <1164285412.13074.131.camel@frg-rhel40-em64t-03>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/06, Xavier Bestel <xavier.bestel@free.fr> wrote:
> On Thu, 2006-11-23 at 14:30 +0200, Yakov Lerner wrote:
> >     Where can I read anything about how kernel is supposed to
> > react to the 'swap-full' condition ? We have troubles on the
> > production machine which routinely arrives to the swap-full state
> > no matter how I increase the swap, because user proceses multi-fork
> > and then want to allocate a lot of virtual memory.
>
> Did you disable memory overcommit ?

When I set overcommit to 1 (2.4 seems not to have 1 vs 2
distinction, am I right), then still root processes are killed
when non-root process is a memory hog. Is there an option
to have malloc return NULL and never kill a process when
malloc fails ?

Thanks
Yakov

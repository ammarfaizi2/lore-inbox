Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWIFIXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWIFIXI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 04:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWIFIXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 04:23:08 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:35775 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750783AbWIFIXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 04:23:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:thread-index:x-mimeole;
        b=H/k9z2IuwGmNQO94WOj4ds1L0FDjE8RbJjLgKrM8W1dcO9/E5hxWSMGL5eKBjojELJBiQpXh83rE5zzk/13kpOQ7BHHAsUo5rxlhVQEmlQFdfxRWgQQ4CEJYvHpbC7u7EVirmVETKzkINLRk2Ofta60xR/muzceBbup1Oy72HOA=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'Heiko Carstens'" <heiko.carstens@de.ibm.com>,
       "'Andrew Morton'" <akpm@osdl.org>
Cc: "'Ingo Molnar'" <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       "'Arjan van de Ven'" <arjan@infradead.org>,
       "'Daniel Walker'" <dwalker@mvista.com>
Subject: RE: lockdep oddity
Date: Wed, 6 Sep 2006 01:23:02 -0700
Message-ID: <004901c6d18d$acc45620$0200a8c0@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20060906080129.GD6898@osiris.boeblingen.de.ibm.com>
Thread-Index: AcbRir1nZOH8+QinTZyd9CsaGEU2ZgAAroRQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are just trading accuracy for speed here.

> On Wed, Sep 06, 2006 at 12:47:24AM -0700, Andrew Morton wrote:
> > On Wed, 6 Sep 2006 09:20:43 +0200
> > Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> > 
> > > I'm also wondering why the profile
> > > patch contains this:
> > > 
> > > +       if (ret)
> > > +               likeliness->count[1]++;
> > > +       else
> > > +               likeliness->count[0]++;
> > > 
> > > This isn't smp safe. Is that on purpose or a bug?
> > 
> > Purposeful.   This is called from all contexts, including NMI.
> 
> Why not use atomic_inc then? Or is there some architecture 
> dependent limitation that it can't be done in every context?


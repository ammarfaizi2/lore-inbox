Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129077AbQJ0O4s>; Fri, 27 Oct 2000 10:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129209AbQJ0O4h>; Fri, 27 Oct 2000 10:56:37 -0400
Received: from 13dyn85.delft.casema.net ([212.64.76.85]:63492 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129077AbQJ0O40>; Fri, 27 Oct 2000 10:56:26 -0400
Message-Id: <200010271456.QAA04258@cave.bitwizard.nl>
Subject: Re: [PROPOSED PATCH] ATM refcount + firestream
In-Reply-To: <39F995E8.FE7324BA@didntduck.org> from Brian Gerst at "Oct 27, 2000
 10:49:12 am"
To: Brian Gerst <bgerst@didntduck.org>
Date: Fri, 27 Oct 2000 16:56:11 +0200 (MEST)
CC: Patrick van de Lageweg <patrick@bitwizard.nl>,
        Andrew Morton <andrewm@uow.edu.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rogier Wolff <wolff@bitwizard.nl>,
        Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
From: R.E.Wolff@bitwizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:
> > > +       struct module *owner;
> > > +       struct module *owner;
> > > bix:/home/morton>
> > 
> > We use it throught the fops_get/fops_put macros to in/decrease the mod
> > counter. See the definitions for those macros (include/linux/fs.h)
> > 
> >         Patrick
> 
> This will break horribly if fops_put/get are changed to inlines instead
> of macros.  They are only supposed to be used on struct file_operations.

Oh?

Anyway, we'll get nice warnings about wrong type of argument when that
happens.

I was the one who found the fops_get/put code useful as a guideline
and also in fact as the code to call.

So the question is: What is the defined interface for fops_get/put: Is
it "it's a macro that... " or is it "it's a function (possibly a macro
for efficiency) that.... "?

				Roger. 

P.S. Apologies for Patrick's bad quoting habits: He had to catch a
train and forgot to delete the rest of the quoted mail.


-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
*       Common sense is the collection of                                *
******  prejudices acquired by age eighteen.   -- Albert Einstein ********
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316667AbSHBSzh>; Fri, 2 Aug 2002 14:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316675AbSHBSzh>; Fri, 2 Aug 2002 14:55:37 -0400
Received: from fachschaft.cup.uni-muenchen.de ([141.84.250.61]:39686 "EHLO
	fachschaft.cup.uni-muenchen.de") by vger.kernel.org with ESMTP
	id <S316667AbSHBSzg>; Fri, 2 Aug 2002 14:55:36 -0400
Message-Id: <200208021858.g72Iwcm03033@fachschaft.cup.uni-muenchen.de>
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: Kasper Dupont <kasperd@daimi.au.dk>
Subject: Re: [RFC] Race condition?
Date: Fri, 2 Aug 2002 20:51:55 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
References: <3D4A8D45.49226E2B@daimi.au.dk> <200208021700.g72H0bm02654@fachschaft.cup.uni-muenchen.de> <3D4ABDBA.35153981@daimi.au.dk>
In-Reply-To: <3D4ABDBA.35153981@daimi.au.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 2. August 2002 19:13 schrieb Kasper Dupont:
> Oliver Neukum wrote:
> > Am Freitag, 2. August 2002 15:46 schrieb Kasper Dupont:
> > > Is there a race condition in this piece of code from do_fork in
> >
> > It would seem so. Perhaps the BKL was taken previously.
>
> I guess you are right. Looking closer on the following lines
> I find a comment stating that nr_threads is protected by the
> kernel lock, but I don't see a lock_kernel() anywhere in this
> code. How about the next code using the nr_threads variable,
> is that safe?

No, it isn't either.
In fact you can even lose updates as it isn't atomic_t.

	Regards
		Oliver


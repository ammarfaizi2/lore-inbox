Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264511AbUAFPVr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 10:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264522AbUAFPVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 10:21:46 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:22168 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S264511AbUAFPVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 10:21:44 -0500
Subject: Re: Possibly wrong BIO usage in ide_multwrite
From: Christophe Saout <christophe@saout.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <200401061538.48904.bzolnier@elka.pw.edu.pl>
References: <1072977507.4170.14.camel@leto.cs.pocnet.net>
	 <200401060059.52833.bzolnier@elka.pw.edu.pl>
	 <20040106113330.GA5827@leto.cs.pocnet.net>
	 <200401061538.48904.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Message-Id: <1073402495.6624.3.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 06 Jan 2004 16:21:36 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di, den 06.01.2004 schrieb Bartlomiej Zolnierkiewicz um 15:38:

> > > > Remember? Can bio be NULL somewhere? Or what do you mean? It's our
> > > > scratchpad and ide_multwrite never puts a NULL bio on it.
> > >
> > > After last sector of the whole transfer is processed ide_multwrite() will
> > > set it to NULL.
> >
> > No, it doesn't.
> 
> Yep, you are right, bio is NULL, but rq->bio is not set...

So, shall I resend the updated patch with the one line moved above the
comment?



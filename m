Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290675AbSAYNo4>; Fri, 25 Jan 2002 08:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290678AbSAYNoh>; Fri, 25 Jan 2002 08:44:37 -0500
Received: from zero.tech9.net ([209.61.188.187]:37381 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S290677AbSAYNob>;
	Fri, 25 Jan 2002 08:44:31 -0500
Subject: Re: kernel BUG at slab.c:1200!
From: Robert Love <rml@tech9.net>
To: Bernd Schubert <bernd.schubert@tc.pci.uni-heidelberg.de>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200201241906.g0OJ68915057@fubini.pci.uni-heidelberg.de>
In-Reply-To: <200201241906.g0OJ68915057@fubini.pci.uni-heidelberg.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 25 Jan 2002 08:49:32 -0500
Message-Id: <1011966573.3501.1.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-01-24 at 14:06, Bernd Schubert wrote:

> we have a machine here that runs quite instable, with 2.2.16 it was crashing quite often and now after a big system 
> update it also crashes with 2.4.17.
> But at least /var/log/messages shows the following errors:

Hi.  The BUG is caused by extra checks on free present by the slab
debugging you have enabled.  I suspect you wouldn't notice a thing if
you turned debugging off ;)

That said, you need to run the oops through ksymoops so we can get a
back trace and see who the offending caller is.

	Robert Love


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbULTIHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbULTIHa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 03:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbULTIFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 03:05:01 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:13966 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261506AbULTH24
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 02:28:56 -0500
Subject: Re: [Lse-tech] [RFC] fork historic module
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Andi Kleen <ak@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>,
       elsa-announce <elsa-announce@lists.sourceforge.net>,
       elsa-devel@frec.bull.fr
In-Reply-To: <20041217151115.GD14229@wotan.suse.de>
References: <1103295512.7329.75.camel@frecb000711.frec.bull.fr>
	 <20041217151115.GD14229@wotan.suse.de>
Date: Mon, 20 Dec 2004 08:28:45 +0100
Message-Id: <1103527725.23891.15.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/12/2004 08:36:24,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/12/2004 08:36:27,
	Serialize complete at 20/12/2004 08:36:27
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-17 at 16:11 +0100, Andi Kleen wrote:
> > +/* IOCTL numbers */
> > +/* If you add a new IOCTL number don't forget to update FH_MAXNR */
> > +#define FH_MAGIC	0x35
> > +#define FH_REGISTER	_IO(FH_MAGIC,0)
> > +#define FH_UNREGISTER	_IO(FH_MAGIC,1)
> 
> Is this really unique? 32bit emulation currently needs unique ioctl numbers.

I read the Documentation/ioctl-number.txt file and 0x35 is not mentioned
in this file. But I made a grep on 'MAGIC' and '35' in the Linux source
tree and you're right, this number is already used by POR_MAGIC_2. 

Is a grep in the Linux source tree is enough to know if the value is
unique?

Thanks,
Guillaume  


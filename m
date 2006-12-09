Return-Path: <linux-kernel-owner+w=401wt.eu-S937641AbWLIU0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937641AbWLIU0O (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 15:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937642AbWLIU0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 15:26:14 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:47736 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937641AbWLIU0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 15:26:13 -0500
Date: Sat, 9 Dec 2006 21:26:12 +0100 (MET)
From: Olaf Hering <olaf@aepfle.de>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] more work_struct mess
Message-ID: <20061209202617.GA4797@aepfle.de>
References: <20061208091649.GL4587@ftp.linux.org.uk>
 <20061209112515.GA1923@aepfle.de> <20061209180451.GY4587@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20061209180451.GY4587@ftp.linux.org.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, Al Viro wrote:

> On Sat, Dec 09, 2006 at 12:25:10PM +0100, Olaf Hering wrote:
> > This is not enough to get it going:
> > 
> > error: 'INIT_WORK' undeclared (first use in this function)
> 
> .config?

Its a gcc bug. It doesnt like the number of arguments for INIT_WORK,
then it appearently tries to evaluate INIT_WORK again, or whatever.

sound/oss/dmasound/tas3001c.c:826:64: error: macro "INIT_WORK" passed 3 arguments, but takes just 2
sound/oss/dmasound/tas3001c.c: In function 'tas3001c_init':
sound/oss/dmasound/tas3001c.c:826: error: 'INIT_WORK' undeclared (first use in this function)

Your patch will fix it.

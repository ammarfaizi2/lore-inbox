Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262793AbUBZNbN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 08:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbUBZNbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 08:31:13 -0500
Received: from soul.math.tau.ac.il ([132.67.192.131]:43476 "EHLO tau.ac.il")
	by vger.kernel.org with ESMTP id S262793AbUBZNbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 08:31:08 -0500
Date: Thu, 26 Feb 2004 15:30:43 +0200 (IST)
From: Hayim Shaul <hayim@post.tau.ac.il>
X-X-Sender: hayim@soul.math.tau.ac.il
To: Benjamin LaHaise <bcrl@kvack.org>
cc: Suparna Bhattacharya <suparna@in.ibm.com>, <akpm@osdl.org>,
       <linux-aio@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Latest AIO patchset
In-Reply-To: <20040225192715.B11294@kvack.org>
Message-ID: <Pine.LNX.4.44.0402261525460.29206-100000@soul.math.tau.ac.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Feb 2004, Benjamin LaHaise wrote:

> On Wed, Feb 25, 2004 at 08:45:29PM +0200, Hayim Shaul wrote:
> > What exactly is the O_DIRECT flag? When I add this flag to the open func
> > it fails.
> > 
> > More specificaly, this function fails
> >   open("filename", O_RDWR | O_DIRECT | O_LARGEFILE | O_CREAT, S_IRWXU);   
> > 
> > but this one succeeds
> >   open("filename", O_RDWR | O_LARGEFILE | O_CREAT, S_IRWXU);   
> > 
> > I'm running linux 2.6.0 with libaio 0.3.92.
> 
> Which filesystem?  Not all support O_DIRECT.
> 

ext3
I'm think it does support ext3.

Actually, I was wrong. open does succeed. It return a valid fd
but after writing and exiting, the file is still zero size.

removing the O_DIRECT with the same prog writes quite alot to the file.

Hayim.


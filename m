Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbUBEDRy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 22:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264361AbUBEDRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 22:17:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:10468 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264358AbUBEDRw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 22:17:52 -0500
Date: Wed, 4 Feb 2004 19:19:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Janet Morgan <janetmor@us.ibm.com>
Cc: daniel@osdl.org, pbadari@us.ibm.com, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, suparna@in.ibm.com
Subject: Re: [PATCH 2.6.2-rc3-mm1] DIO read race fix
Message-Id: <20040204191921.62122c15.akpm@osdl.org>
In-Reply-To: <4021B07E.8030700@us.ibm.com>
References: <3FCD4B66.8090905@us.ibm.com>
	<1070674185.1929.9.camel@ibm-c.pdx.osdl.net>
	<1070907814.707.2.camel@ibm-c.pdx.osdl.net>
	<1071190292.1937.13.camel@ibm-c.pdx.osdl.net>
	<20031230045334.GA3484@in.ibm.com>
	<1072830557.712.49.camel@ibm-c.pdx.osdl.net>
	<20031231060956.GB3285@in.ibm.com>
	<1073606144.1831.9.camel@ibm-c.pdx.osdl.net>
	<20040109035510.GA3279@in.ibm.com>
	<1075945198.7182.46.camel@ibm-c.pdx.osdl.net>
	<20040204180754.28801410.akpm@osdl.org>
	<4021B07E.8030700@us.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Janet Morgan <janetmor@us.ibm.com> wrote:
>
> >Daniel McNeil <daniel@osdl.org> wrote:
>  >  
>  >
>  >>I have found (finally) the problem causing DIO reads racing with
>  >>buffered writes to see uninitialized data on ext3 file systems 
>  >>(which is what I have been testing on).
>  >>    
>  >>
>  >
>  >What kernel?  If -mm, is this the only remaining buffered-vs-direct
>  >problem?
>  >
>  >  
>  >
>  I think there was consensus on two other patches along the way:
> 
>      http://marc.theaimsgroup.com/?l=linux-kernel&m=107286971311559&w=2
>      http://marc.theaimsgroup.com/?l=linux-aio&m=107291089712224&w=2

Yes, I think those are needed but this thing has been dragging on for so
long it has become a little unclear.  This was the main reason why I backed
off the fs-aio patches.

Daniel, could you please work out whether we actually need those patches
and if so, prep them for us?  Presumably if ext2 passes all testing without
those patches, we do not need them.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbTFBPoZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 11:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbTFBPoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 11:44:25 -0400
Received: from inetc.connecttech.com ([64.7.140.42]:53003 "EHLO
	inetc.connecttech.com") by vger.kernel.org with ESMTP
	id S262486AbTFBPoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 11:44:23 -0400
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "'Brian Gerst'" <bgerst@didntduck.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Redundant code?
Date: Mon, 2 Jun 2003 11:58:23 -0400
Organization: Connect Tech Inc.
Message-ID: <00ef01c3291f$cb9cc600$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <3EDB7053.3040707@didntduck.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: linux-kernel-owner@vger.kernel.org 
> Stuart MacDonald wrote:
> > --- linux-2.5.70/fs/select.c	2003-05-26 
> 21:00:21.000000000 -0400
> > +++ linux-2.5.70-new/fs/select.c	2003-06-02 
> 11:40:24.000000000 -0400
> > @@ -344,9 +344,6 @@
> >  	    (ret = get_fd_set(n, outp, fds.out)) ||
> >  	    (ret = get_fd_set(n, exp, fds.ex)))
> >  		goto out;
> > -	zero_fd_set(n, fds.res_in);
> > -	zero_fd_set(n, fds.res_out);
> > -	zero_fd_set(n, fds.res_ex);
> >  
> >  	ret = do_select(n, &fds, &timeout);
> 
> fds.in != fds.res_in

<smacks forehead> You are correct.

..Stu


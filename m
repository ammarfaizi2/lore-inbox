Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVA1AEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVA1AEE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 19:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVA0XvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 18:51:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:32225 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261278AbVA0XfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 18:35:09 -0500
Date: Thu, 27 Jan 2005 15:35:02 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: ierdnah <ierdnah@go.ro>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel oops!
In-Reply-To: <1106866066.20523.3.camel@ierdnac>
Message-ID: <Pine.LNX.4.58.0501271532420.2362@ppc970.osdl.org>
References: <1106437010.32072.0.camel@ierdnac>  <Pine.LNX.4.58.0501222223090.4191@ppc970.osdl.org>
  <1106483340.21951.4.camel@ierdnac>  <Pine.LNX.4.58.0501230943020.4191@ppc970.osdl.org>
 <1106866066.20523.3.camel@ierdnac>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 28 Jan 2005, ierdnah wrote:
> 
> is this patch better? should i test this too?

You probably should. The patch you've tested is really ugly, and not a fix 
at all - it's really just depending on the compiler generating a specific 
code sequence that will hide the race.  As such, it's a patch I would only 
accept in the standard kernel as an absolute last resort.

In contrast, the second patch I tested may actually _fix_ the race. 

The fact that the first patch makes the oops go away is a good thing, 
though: it shows that your oops really was due to that small race window, 
and as such it helps validate that it wasn't anything else.

Thanks,

		Linus

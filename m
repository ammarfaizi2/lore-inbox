Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262858AbVFXONN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262858AbVFXONN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 10:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263010AbVFXONE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 10:13:04 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:59116 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262918AbVFXOMK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 10:12:10 -0400
Date: Fri, 24 Jun 2005 19:39:18 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "Artem B. Bityuckiy" <dedekind@oktetlabs.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] files: change fd_install assertion
Message-ID: <20050624140918.GA4562@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050624105011.GB4804@in.ibm.com> <20050624105209.GC4804@in.ibm.com> <20050624105318.GD4804@in.ibm.com> <20050624105410.GE4804@in.ibm.com> <42BBF6D5.2030109@oktetlabs.ru> <20050624130049.GG4804@in.ibm.com> <42BC10C9.9020309@oktetlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BC10C9.9020309@oktetlabs.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 05:55:21PM +0400, Artem B. Bityuckiy wrote:
> Dipankar Sarma wrote:
> >Because that way the compare and branch can be ifdefed out when CONFIG_BUG 
> >is
> >not set. Not to mention BUG_ON() looks more like an assertion.
> 
> Surely, even if BUG() will be nothing, the compiler will optimize that?
> Yes, it looks better, but I don't like that there was unlikely() before 
> and you removed it. I'ts minor though.

I did not. BUG_ON() is supposed to have unlikely() inside. See the
generic version. If an arch specific BUG_ON() doesn't have some
branch hint, it definitely should.

Thanks
Dipankar

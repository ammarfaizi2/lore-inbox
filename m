Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263245AbTECDhw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 23:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263246AbTECDhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 23:37:52 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:20940 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263245AbTECDhv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 23:37:51 -0400
Date: Sat, 3 May 2003 09:23:00 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reducing overheads in fget/fput
Message-ID: <20030503035300.GA1407@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030428165240.GA1105@in.ibm.com> <20030428193228.GP10374@parcelfarce.linux.theplanet.co.uk> <20030428195836.GD1105@in.ibm.com> <20030502171726.GA1414@in.ibm.com> <20030502135404.0ba2ca66.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030502135404.0ba2ca66.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 02, 2003 at 01:54:04PM -0700, Andrew Morton wrote:
> Dipankar Sarma <dipankar@in.ibm.com> wrote:
> > Here is a patch that fixes that.
> 
> This patch is fairly foul.

Not sure what your grouse is, but I don't like the fget_ligth()/fput_light
semantics myself. They don't seem natural, but I can't think of
better way to do this. 

> 
> > kernel           sys time     std-dev
> > ------------     --------     -------
> > UP - vanilla     2.104        0.028
> > SMP - vanilla    2.976        0.023
> > UP - file        1.867        0.019
> > SMP - file       2.719        0.026
> 
> But it is localised, and makes a substantial difference.

If I haven't broken too many things, then I will try to get some
performance results from large machines.

> 
> I inlined fput_light:

Looks good.

Thanks
Dipankar

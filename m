Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbULCVcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbULCVcx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 16:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbULCVce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 16:32:34 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:59994 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261587AbULCVcc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 16:32:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=jLV76MG/0Va9NHDW5jzZKz4rvqaWdoBkaZQjwcvGMirlSVvjeOIW9p0NtysHS6pKB9BQ6FjE7EQluswYPmuh9pDl7CgvLm89bPWBPxhMEnOmhon1odyAIENpWXYARxyIahC40/G7kVetcskx+VlHl8+bC10rqmP+QQhS6IDiTT0=
Message-ID: <64b1faec0412031332573712e9@mail.gmail.com>
Date: Fri, 3 Dec 2004 22:32:31 +0100
From: Sylvain <autofr@gmail.com>
Reply-To: Sylvain <autofr@gmail.com>
To: Brian Gerst <bgerst@didntduck.org>
Subject: Re: distinguish kernel thread / user task
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <41B0D18B.3020309@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <64b1faec041203091654251b18@mail.gmail.com>
	 <41B0BD6B.2010809@didntduck.org>
	 <64b1faec0412031215b934a9@mail.gmail.com>
	 <41B0D18B.3020309@didntduck.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel threads have no mm struct, right.
but it appears some programs (user tasks) haven't either ?! actually,
that what I notice..

Sylvain



On Fri, 03 Dec 2004 15:50:19 -0500, Brian Gerst <bgerst@didntduck.org> wrote:
> Sylvain wrote:
> > I am trying to do a tool to record task switching...separating also
> > kernel/user tasks, but I got some trouble with that last case.
> >
> > I confused since "ps" is actually able to distinguish kernel thread
> > from user task.
> > I wouldn't had a flag if It 's not necessary
> >
> > Sylvain
> >
> 
> Pstools doesn't really know the difference between user and kernel
> threads.  It only shows kernel threads as swapped out (in brackets)
> because they have an RSS of zero (since kernel threads have no mm struct).
> 
> --
>                                Brian Gerst
>

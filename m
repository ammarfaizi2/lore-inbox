Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbVIDMMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbVIDMMf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 08:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbVIDMMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 08:12:35 -0400
Received: from nproxy.gmail.com ([64.233.182.197]:63642 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750766AbVIDMMe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 08:12:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Im9v2+X3cfckG9UTukBZHRVEz/Ki2H4z7dZg+WYmYffCazrLMdjsr8/0KLWW6j5zgFIkg5Jv0FTQ64iA6yirEIDsEIt4gzxWUE9pDR5yi89ZQtdeErAzCKYaDK+Bxv3tyBMX+lHAZJc21pKaFLiHLk817p7Pfdzj5Ep++HKu++M=
Message-ID: <3d8471ca0509040512762e283a@mail.gmail.com>
Date: Sun, 4 Sep 2005 14:12:28 +0200
From: Guillaume Chazarain <guichaz@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: RFC: i386: kill !4KSTACKS
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
In-Reply-To: <1125805704.14032.71.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050902003915.GI3657@stusta.de>
	 <1125805704.14032.71.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/9/4, Lee Revell <rlrevell@joe-job.com>:
> On Fri, 2005-09-02 at 02:39 +0200, Adrian Bunk wrote:
> > 4Kb kernel stacks are the future on i386, and it seems the problems it
> > initially caused are now sorted out.
> >
> > Does anyone knows about any currently unsolved problems?
> 
> ndiswrapper

Just a thought : why couldn't ndiswrapper set apart some piece
of memory and use it as the stack by changing the esp register
before executing windows code.

Like http://article.gmane.org/gmane.linux.drivers.ndiswrapper.general/4737

It's dirty, I know, but after all they are executing win32 code ...

Why wouldn't this work ?

-- 
Guillaume

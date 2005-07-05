Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbVGEUHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbVGEUHY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 16:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbVGEUHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 16:07:24 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:22345 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261741AbVGEUFh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 16:05:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T2eiW7DMhTh8ic4elSIntqky7YeG2LYcv850KmP9DLAZZ2f3fMDdVoQZhAfUMbmmAYdf9EqenPjMcyQLRoKILkpqNWl6BM3xbszsx5DVG3d9jEY7FNlGM/qeMxC6+QEYOIu5zgFe2GMjTIo3J9Xyqg2Tt9LtzbbDRrfduuePV3o=
Message-ID: <4ae3c14050705130544e5abc1@mail.gmail.com>
Date: Tue, 5 Jul 2005 16:05:35 -0400
From: Xin Zhao <uszhaoxin@gmail.com>
Reply-To: Xin Zhao <uszhaoxin@gmail.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: Why cannot I do "insmod nfsd.ko" directly?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200507051858.j65IwKlv005612@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <uszhaoxin@gmail.com> <4ae3c140507051123758bb61e@mail.gmail.com>
	 <200507051858.j65IwKlv005612@laptop11.inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just found the problem. I have to insmod exportfs.ko first. 

I can certainly use modprobe, but what I really want to do is to use
my own nfsd.ko instead of the default one.  But my nfsd.ko is not in
the default /lib/module/... directory. So if I use modprobe, it will
complaint cannot find nfsd.ko.

How to do this? Thanks!

-x

On 7/5/05, Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> Xin Zhao <uszhaoxin@gmail.com> wrote:
> > I tried to do "insmod nfsd.ko", but always got the error message
> > "insmod: error inserting 'nfsd.ko': -1 Unknown symbol in module"
> 
> Use modprobe(8), it knows about module dependencies and what to load.
> --
> Dr. Horst H. von Brand                   User #22616 counter.li.org
> Departamento de Informatica                     Fono: +56 32 654431
> Universidad Tecnica Federico Santa Maria              +56 32 654239
> Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
>

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbVHQCRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbVHQCRR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 22:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbVHQCRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 22:17:17 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:13204 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750795AbVHQCRR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 22:17:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fFe14l9RZMwjrJxBFqyogFL5pDsWI2OPS58V3yyeg7GwLy3+yt7So3+CXYSfVVLzi0svlYzIlN/+c3BLMLfB80ff6tv8K91z8JkuFNBTvWBdHWeoOafrRRWRHpmxEUSap6+oC1Bp8ExftQjKoDhRCw3Ew2ipyepZd+5NBtdFiTM=
Message-ID: <4f52331f05081619176c9fd472@mail.gmail.com>
Date: Tue, 16 Aug 2005 19:17:15 -0700
From: Fong Vang <sudoyang@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4 and 2.6 kernel module
In-Reply-To: <4f52331f050816190542249721@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4f52331f050816190542249721@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Found the answer by googling further.  It's been renamed to vermagic.

   strings reiserfs.ko|grep vermagic
   vermagic=2.6.9-11.EL 586 REGPARM 4KSTACKS gcc-3.4


On 8/16/05, Fong Vang <sudoyang@gmail.com> wrote:
> In the 2.4 kernel, modules contain the "kernel_version" identification
> in the module itself.  This is an example from the 2.4.18 reiserfs
> kernel module:
> 
> kernel_version=2.4.18-27.7.xbigmem
> using_checksums=1
> description=ReiserFS journaled filesystem
> author=Hans Reiser <reiser@namesys.com>
> license=GPL
> kernel_version=2.4.18-27.7.xbigmem
> using_checksums=1
> 
> 
> This ID doesn't seem to exist anymore in the 2.6 kernel.  How does a
> 2.6 kernel know if a module is compatible?
> 
> Thanks for any help.
>

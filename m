Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbVLBMHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbVLBMHs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 07:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbVLBMHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 07:07:48 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:1454 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1750705AbVLBMHr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 07:07:47 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Subject: Re: Use enum to declare errno values
Date: Fri, 2 Dec 2005 14:07:02 +0200
User-Agent: KMail/1.8.2
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Paul Jackson <pj@sgi.com>, francis_moreau2000@yahoo.fr,
       linux-kernel@vger.kernel.org
References: <20051123132443.32793.qmail@web25813.mail.ukl.yahoo.com> <200512020849.28475.vda@ilport.com.ua> <2cd57c900512020127m5c7ca8e1u@mail.gmail.com>
In-Reply-To: <2cd57c900512020127m5c7ca8e1u@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512021407.02794.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 December 2005 11:27, Coywolf Qi Hunt wrote:
> 2005/12/2, Denis Vlasenko <vda@ilport.com.ua>:
> > On Thursday 01 December 2005 22:01, linux-os (Dick Johnson) wrote:
> > > On Thu, 24 Nov 2005, Paul Jackson wrote:
> > >
> > > > If errno's were an enum type, what would be the type
> > > > of the return value of a variety of kernel routines
> > > > that now return an int, returning negative errno's on
> > > > error and zero or positive values on success?
> > >
> > > enums are 'integer types', one of the reasons why #defines
> > > which are also 'integer types' are just as useful. If you
> > > want to auto-increment these integer types, then enums are
> > > useful. Otherwise, just use definitions.
> >
> > There is another reason why enums are better than #defines:
> 
> This is a reason why enums are worse than #defines.

Why?

> > file.c:
> > ...
> > #include "something_which_eventually_includes_file.h"
> > ...
> > int f(int foo, int bar)
> > {
> >         return foo+bar;
> > }

This gets converted to "int f(int 123, int bar)" when foo
is a #define. Do you disagree that it is bad?
--
vda

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965048AbWD0OnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbWD0OnK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 10:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbWD0OnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 10:43:09 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:919 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S965048AbWD0OnI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 10:43:08 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: C++ pushback
Date: Thu, 27 Apr 2006 17:41:41 +0300
User-Agent: KMail/1.8.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <65Jcu-3js-23@gated-at.bofh.it> <66fcv-Cu-9@gated-at.bofh.it> <4450D3CD.9060002@shaw.ca>
In-Reply-To: <4450D3CD.9060002@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604271741.41999.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 April 2006 17:23, Robert Hancock wrote:
> Denis Vlasenko wrote:
> > Random example. gcc-3.4.3/include/g++-v3/bitset:
> > 
> >   template<size_t _Nw>
> >     struct _Base_bitset
> >     {
> >       typedef unsigned long _WordT;
> > 
> >       /// 0 is the least significant word.
> >       _WordT            _M_w[_Nw];
> > 
> >       _Base_bitset() { _M_do_reset(); }
> > ...
> >       void
> >       _M_do_set()
> >       {
> >         for (size_t __i = 0; __i < _Nw; __i++)
> >           _M_w[__i] = ~static_cast<_WordT>(0);
> >       }
> >       void
> >       _M_do_reset() { memset(_M_w, 0, _Nw * sizeof(_WordT)); }
> > ...
> > 
> 
> ..
> 
> > Why _M_do_reset() is not inlined?
> 
> It is.. anything declared as part of the declaration is considered 
> inline by default.

You're right, I forgot about that 

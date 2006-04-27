Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965123AbWD0OXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965123AbWD0OXY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 10:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965126AbWD0OXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 10:23:24 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:18623 "EHLO
	pd4mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S965123AbWD0OXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 10:23:23 -0400
Date: Thu, 27 Apr 2006 08:23:09 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: C++ pushback
In-reply-to: <66fcv-Cu-9@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Denis Vlasenko <vda@ilport.com.ua>
Message-id: <4450D3CD.9060002@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <65Jcu-3js-23@gated-at.bofh.it> <665wi-39E-3@gated-at.bofh.it>
 <669JO-WQ-59@gated-at.bofh.it> <66fcv-Cu-9@gated-at.bofh.it>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> Random example. gcc-3.4.3/include/g++-v3/bitset:
> 
>   template<size_t _Nw>
>     struct _Base_bitset
>     {
>       typedef unsigned long _WordT;
> 
>       /// 0 is the least significant word.
>       _WordT            _M_w[_Nw];
> 
>       _Base_bitset() { _M_do_reset(); }
> ...
>       void
>       _M_do_set()
>       {
>         for (size_t __i = 0; __i < _Nw; __i++)
>           _M_w[__i] = ~static_cast<_WordT>(0);
>       }
>       void
>       _M_do_reset() { memset(_M_w, 0, _Nw * sizeof(_WordT)); }
> ...
> 

..

> Why _M_do_reset() is not inlined?

It is.. anything declared as part of the declaration is considered 
inline by default.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319072AbSHMUyI>; Tue, 13 Aug 2002 16:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319073AbSHMUyH>; Tue, 13 Aug 2002 16:54:07 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27401 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319072AbSHMUyH>; Tue, 13 Aug 2002 16:54:07 -0400
Message-ID: <3D5972BE.3020300@zytor.com>
Date: Tue, 13 Aug 2002 13:57:34 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en, sv
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] clone_startup(), 2.5.31-A0
References: <Pine.LNX.4.44.0208131650230.30647-100000@localhost.localdomain>	<20020813160924.GA3821@codepoet.org>	<20020813171138.A12546@infradead.org>	<15705.13490.713278.815154@napali.hpl.hp.com>	<ajbo1b$e2a$1@cesium.transmeta.com>	<15705.27073.997831.983519@napali.hpl.hp.com>	<3D596B96.4000305@zytor.com> <15705.29059.306202.720523@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:
>>>>>>On Tue, 13 Aug 2002 13:27:02 -0700, "H. Peter Anvin" <hpa@zytor.com> said:
>>>>>
> 
>   >> I was, however, the flaws that you complained of had nothing to
>   >> do with the syscall -- it's all in the syscall wrapper (which is
>   >> required for clone(), like it or not.)
> 
> The issue is not whether a wrapper is needed or not.
> 
> My point is that it is cleaner to always describe stack areas as
> memory areas (e.g., as a base/size pair).  Note that this is
> effectively what's happening in the platform-independent part of the
> kernel today.
> 

Right, but all the stack handling is a matter of the wrapper.  sys_clone
doesn't affect the stack at all.

	-hpa



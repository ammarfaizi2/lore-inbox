Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161217AbWHDODL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161217AbWHDODL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 10:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161213AbWHDODK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 10:03:10 -0400
Received: from jaguar.mkp.net ([192.139.46.146]:2230 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S1161216AbWHDODJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 10:03:09 -0400
To: Jeff Garzik <jeff@garzik.org>
Cc: ricknu-0@student.ltu.se, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] A generic boolean
References: <1153341500.44be983ca1407@portal.student.luth.se>
	<44BE9E78.3010409@garzik.org>
From: Jes Sorensen <jes@sgi.com>
Date: 04 Aug 2006 10:03:08 -0400
In-Reply-To: <44BE9E78.3010409@garzik.org>
Message-ID: <yq0lkq4vbs3.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jeff" == Jeff Garzik <jeff@garzik.org> writes:

Jeff> ricknu-0@student.ltu.se wrote:
>> A first step to a generic boolean-type. The patch just introduce
>> the bool (in

Jeff> Since gcc supports boolean types and can optimize for such,
Jeff> introducing bool is IMO a good thing.

>> -Why would we want it?  -There is already some how are depending on
>> a "boolean"-type (like NTFS). Also, it will clearify functions who
>> returns a boolean from one returning a value, ex: bool it_is_ok();
>> char it_is_ok(); The first one is obvious what it is doing, the
>> secound might return some sort of status.

Jeff> A better reason is that there is intrinsic compiler support for
Jeff> booleans.

Well late to the dicussion, but I still want to point out that forcing
a boolean type of a different size upon existing kernel code is not
always a great idea and can have nasty side effects for struct
alignments. Not to mention that on some architectures, accessing a u1
is a lot slower than accessing an int. If a developer really wants to
use the smaller type he/she should do so explicitly being aware of the
impact.

The kernel is written in C, not C++ or Jave or some other broken
language and C doesn't have 'bool'. This patch falls under the
'typedefs considered evil' or typedef for the sake of typedef, if you
ask me.

Regards,
Jes

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161225AbWHDOfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161225AbWHDOfj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 10:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161232AbWHDOfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 10:35:39 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:41903 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161226AbWHDOfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 10:35:37 -0400
Message-ID: <44D35B25.9090004@sgi.com>
Date: Fri, 04 Aug 2006 16:35:17 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, ricknu-0@student.ltu.se,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] A generic boolean
References: <1153341500.44be983ca1407@portal.student.luth.se>	 <44BE9E78.3010409@garzik.org>  <yq0lkq4vbs3.fsf@jaguar.mkp.net> <1154702572.23655.226.camel@localhost.localdomain>
In-Reply-To: <1154702572.23655.226.camel@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Gwe, 2006-08-04 am 10:03 -0400, ysgrifennodd Jes Sorensen:
>> alignments. Not to mention that on some architectures, accessing a u1
>> is a lot slower than accessing an int. If a developer really wants to
>> use the smaller type he/she should do so explicitly being aware of the
>> impact.
> 
> Which is just fine. Nobody at the moment is using the bool type because
> we don't have one. Nor is a C bool necessarily u1.

The proposed patch makes it u1 - if we end up with arch specific
defines, as the patch is proposing, developers won't know for sure what
the size is and will get alignment wrong. That is not fine.

If we really have to introduce a bool type, at least it has to be the
same size on all 32 bit archs and the same size on all 64 bit archs.

But again, the end result is we end up with yet another typedef for the
sake of introducing a typedef.

>> The kernel is written in C, not C++ or Jave or some other broken
>> language and C doesn't have 'bool'. 
> 
> Oh yes it does, as of C99 via stdbool.h. The only reason its not always
> "bool" is compatibility considerations. Welcome to the 21st century.

*Shiver*, I guess we'll need a machine that is PC2007 or whatever
compliant to run Linux next.

Jes

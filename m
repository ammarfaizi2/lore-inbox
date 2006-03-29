Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbWC2Vah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWC2Vah (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 16:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWC2Vah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 16:30:37 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:51598 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1750890AbWC2Vag
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 16:30:36 -0500
Subject: Re: [Devel] Re: [RFC] [PATCH 0/7] Some basic vserver infrastructure
From: Sam Vilain <sam@vilain.net>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Kirill Korotaev <dev@sw.ru>, devel@openvz.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Herbert Poetzl <herbert@13thfloor.at>, Mishin Dmitry <dim@sw.ru>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
In-Reply-To: <20060329134709.GC15745@sergelap.austin.ibm.com>
References: <20060321061333.27638.63963.stgit@localhost.localdomain>
	 <1142967011.10906.185.camel@localhost.localdomain>
	 <44206B58.5000404@vilain.net>
	 <1142976756.10906.200.camel@localhost.localdomain>
	 <4420885F.5070602@vilain.net> <m1bqvzq7de.fsf@ebiederm.dsl.xmission.com>
	 <44241214.7090405@sw.ru> <20060327124517.GA16114@sergelap.austin.ibm.com>
	 <442A7879.20802@sw.ru>  <20060329134709.GC15745@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Thu, 30 Mar 2006 09:30:44 +1200
Message-Id: <1143667844.9969.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-29 at 07:47 -0600, Serge E. Hallyn wrote:
> Alas, the spacing on the picture didn't quite work out :)  I think that
> by nested containers, you mean overlapping nested containers.  In your
> example, how are you suggesting that cont1 refers to items in
> container1.1.2's shmem?  I assume, given your previous posts on openvz,
> that you want every shmem id in all namespaces "nested" under cont1 to
> be unique, and for cont1 to refer to any item in container1.1.2's
> namespace just as it would any of cont1's own shmem?
> 
> In that case I am not sure of the actual usefulness.  Someone with
> different use for containers (you? :)  will need to justify it.  For me,
> pure isolation works just fine.  Clearly it will be most useful if we
> want fine-grained administration, from parent namespaces, of the items
> in a child namespace.

The overlapping is important if you want to pretend that the
namespace-able resources are allowed to be specified per-process, when
really they are specified per-family.

In this way, a process family is merely a grouping of processes with
like namespaces, and depending on which way they overlap you get the
same behaviour as when processes only have one resource different, and
therefore remove the overhead on fork().

Sam.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWDRUec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWDRUec (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 16:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWDRUec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 16:34:32 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:25769 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932304AbWDRUeb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 16:34:31 -0400
Date: Tue, 18 Apr 2006 12:33:14 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: =?ISO-8859-1?Q?T=F6r=F6k?= Edwin <edwin@gurde.com>,
       fireflier-devel@lists.sourceforge.net,
       Arjan van de Ven <arjan@infradead.org>,
       Crispin Cowan <crispin@novell.com>,
       Karl MacMillan <kmacmillan@tresys.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, James Morris <jmorris@namei.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Fireflier-devel] Re: [RESEND][RFC][PATCH 2/7] implementationof
 LSM hooks
In-Reply-To: <1145392307.21723.44.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0604181230390.22439@qynat.qvtvafvgr.pbz>
References: <E1FVtPV-0005zu-00@w-gerrit.beaverton.ibm.com>  <44453E7B.1090009@novell.com>
  <1145389813.2976.47.camel@laptopd505.fenrus.org>  <200604182313.05604.edwin@gurde.com>
 <1145392307.21723.44.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2006, Alan Cox wrote:

> Subject: Re: [Fireflier-devel] Re: [RESEND][RFC][PATCH 2/7] implementationof
>     LSM hooks
> 
> On Maw, 2006-04-18 at 23:13 +0300, Török Edwin wrote:
>> In the current version we intended to use mountpoint+inode to identify
>> programs. This reduces the potential problems from your list to: fd passing.
>
> Inode numbers are not constant on all file systems unless the file is
> currently open. That is a pain in the butt when you want to describe a
> file as well but it is how things work out.

could you take an approach similar to git, store the length and a hash of 
the first X amount of the file (for good performance say the first block, 
for best security say the entire file)? is there a hash that's cheap 
enough to calculate that this is reasonable? (although it would end up 
trashing the cpu cache in any case, loosing a bunch of the benifits of 
DMA)

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare


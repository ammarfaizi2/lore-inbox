Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbUDCBVj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 20:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbUDCBVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 20:21:39 -0500
Received: from codepoet.org ([166.70.99.138]:63430 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S261246AbUDCBVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 20:21:38 -0500
Date: Fri, 2 Apr 2004 18:21:12 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: Pavel Machek <pavel@ucw.cz>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>, mj@ucw.cz,
       jack@ucw.cz, "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040403012112.GA6499@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	Jamie Lokier <jamie@shareable.org>, Pavel Machek <pavel@ucw.cz>,
	=?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	mj@ucw.cz, jack@ucw.cz,
	"Patrick J. LoPresti" <patl@users.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <20040329171245.GB1478@elf.ucw.cz> <s5g7jx31int.fsf@patl=users.sf.net> <20040329231635.GA374@elf.ucw.cz> <20040402165440.GB24861@wohnheim.fh-wedel.de> <20040402180128.GA363@elf.ucw.cz> <20040402181707.GA28112@wohnheim.fh-wedel.de> <20040402182357.GB410@elf.ucw.cz> <20040402200921.GC653@mail.shareable.org> <20040402213933.GB246@elf.ucw.cz> <20040403010425.GJ653@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040403010425.GJ653@mail.shareable.org>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Apr 03, 2004 at 02:04:25AM +0100, Jamie Lokier wrote:
> Here's a tricky situation:
> 
>    1. A file is cowlinked.  Then each cowlink is mmap()'d, one per process.
> 
>    2. At this point both mappings share the same pages in RAM.
> 
>    3. Then one of the cowlinks is written to...

Using mmap with PROT_WRITE on a cowlink must preemptively
break the link.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268397AbUJOTtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268397AbUJOTtq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 15:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268410AbUJOTtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 15:49:46 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:60547 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S268397AbUJOTtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 15:49:43 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: Announcing Binary Compatibility/Testing
Date: Fri, 15 Oct 2004 21:49:13 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.10.15.19.49.12.958286@smurf.noris.de>
References: <1097705813.6077.52.camel@wookie-zd7> <416DAEB7.4050108@pobox.com> <1097709855.5411.20.camel@localhost>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: server.smurf.noris.de 1097869753 2650 192.109.102.35 (15 Oct 2004 19:49:13 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Fri, 15 Oct 2004 19:49:13 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Robert Love wrote:

> Any other incompatibility lies in libraries, but we have library
> versioning.  There is nothing wrong with newer libs breaking
> compatibility so long as they have a different soname.

Glibc doesn't use library versioning. It uses *symbol* versioning.

Thus, for some library entry points you now see multiple symbols with the
same name but different versions (ancient vs. old vs. new "struct stat",
16- vs. 32-bit UID, whatever). As long as the header files you compile
against match the library you link to, it all works transparently.

For the library's user, that is. The author's job is harder...

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de


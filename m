Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262849AbUDGLKQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 07:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbUDGLKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 07:10:15 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:13798 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S262849AbUDGLKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 07:10:09 -0400
Message-ID: <4073C33B.7B7808E7@nospam.org>
Date: Wed, 07 Apr 2004 11:00:43 +0200
From: Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org>
Reply-To: Zoltan.Menyhart@bull.net
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev@lists.linuxppc.org
Subject: Re: RFC: COW for hugepages
References: <20040407074239.GG18264@zax>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

Why not just add a flag for a VMA telling if you want / do not want to
copy it on "fork()" ? E.g.:

dup_mmap():

	for (= current->mm->mmap ; mpnt ; mpnt = mpnt->vm_next) {

		if (mpnt->vm_flags & VM_HUGETLB_DONT_COPY)
			<do nothing>
	}

Regards,

Zoltán Menyhárt

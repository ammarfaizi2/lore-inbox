Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWFSS1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWFSS1j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWFSS1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:27:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:58360 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751283AbWFSS1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:27:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=CL4vreJRQ6lrp+2c40xMUw+LJL3Ry0kV4tZBmmrSaeswaiFLjdCFYOa8PGhALKSXozHQhIMWgD6aDES4bna9zadsTJ90XB/n3WLh0M2FNl1IZAdjd4pg7d+XE5jco9aD7ZkmBMxtyTN0ydz+PdTSkQF82vwWLGls9pCfYauoX0I=
Message-ID: <177b81ff0606191127s48d5c616wfbd46b4b3334567@mail.gmail.com>
Date: Mon, 19 Jun 2006 13:27:36 -0500
From: "Cory Grunden" <cory.grunden@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-rt1 and reiser4
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having a problem with building 2.6.17-rt1 with reiser4 support.

build error:

fs/built-in.o: In function `unhash_unformatted_node_nolock':
jnode.c:(.text+0x446b2): undefined reference to `__bad_spinlock_type'
jnode.c:(.text+0x446bd): undefined reference to `__bad_spinlock_type'
fs/built-in.o: In function `find_get_jnode':
(.text+0x45321): undefined reference to `__bad_spinlock_type'
fs/built-in.o: In function `find_get_jnode':
(.text+0x4532c): undefined reference to `__bad_spinlock_type'
fs/built-in.o: In function `reiser4_set_page_dirty':
(.text+0x62b51): undefined reference to `__bad_spinlock_type'
fs/built-in.o:(.text+0x62b80): more undefined references to
`__bad_spinlock_type' follow
make: *** [.tmp_vmlinux1] Error 1

>From what I can tell, it has to do with some incompatibility with -rt
spinlock.h additions and reiser4.  Does anybody have a fix for this?

Thanks.

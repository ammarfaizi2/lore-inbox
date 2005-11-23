Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbVKWOxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbVKWOxz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 09:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbVKWOxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 09:53:54 -0500
Received: from ns.suse.de ([195.135.220.2]:52684 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750875AbVKWOxy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 09:53:54 -0500
To: Chris Adams <cmadams@hiwaay.net>
Cc: linux-kernel@vger.kernel.org
Subject: Generation numbers in stat was Re: what is slashdot's answer to ZFS?
References: <fa.d8ojg69.1p5ovbb@ifi.uio.no>
	<20051122161712.GA942598@hiwaay.net>
	<1132690779.20233.74.camel@localhost.localdomain>
	<20051122195652.GB660478@hiwaay.net>
From: Andi Kleen <ak@suse.de>
Date: 23 Nov 2005 12:20:35 -0700
In-Reply-To: <20051122195652.GB660478@hiwaay.net>
Message-ID: <p731x17jhmk.fsf_-_@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Adams <cmadams@hiwaay.net> writes:
> 
>   [Tru64 UNIX]  However, in the rare case when a user application has been
>   deleting open files, and a file serial number is reused, a third structure
>   member in <sys/stat.h>, the file generation number, is needed to uniquely
>   identify a file. This member, st_gen, is used in addition to st_ino and
>   st_dev.

Sounds like a cool idea. Many fs already maintain this information
in the kernel. We still had some unused pad space in the struct stat
so it could be implemented without any compatibility issues 
(e.g. in place of __pad0). On old kernels it would be always 0.

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264132AbTLYJ3T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 04:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264238AbTLYJ3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 04:29:19 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:60636 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S264132AbTLYJ3R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 04:29:17 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16362.44523.653063.676562@laputa.namesys.com>
Date: Thu, 25 Dec 2003 12:29:15 +0300
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiser4 breaks vmware
In-Reply-To: <p73pted2772.fsf@verdi.suse.de>
References: <1072202167.8127.15.camel@localhost.suse.lists.linux.kernel>
	<3FE8B765.6000907@vgertech.com.suse.lists.linux.kernel>
	<16361.18888.602000.438746@laputa.namesys.com.suse.lists.linux.kernel>
	<p73pted2772.fsf@verdi.suse.de>
X-Mailer: VM 7.17 under 21.5  (beta16) "celeriac" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
 > Nikita Danilov <Nikita@Namesys.COM> writes:
 > 
 > > Exactly. I included it into core.diff by mistake.
 > > Revert it: http://www.namesys.com/snapshots/2003.12.23/broken-out/do_mmap2-fix.diff.patch
 > 
 > There seem to be some other unnecessary patches in there, like
 > init_fixmap_vma.diff.patch. I cannot imagine why a file system should

Yes, UML left-over also, thank you for noting.

 > need to change that. Same with spinlock-owner.diff.patch. Is that
 > really needed? If yes porting it to all architectures will be a lot of

No, it is debugging code, and I think it is reasonably to ship it
together with reiser4 while it is in the debugging stage. Debugging
patches are going to be removed eventually.

 > work.
 > 
 > I would suggest separating your debug patches, like page-owner.diff.patch
 > 
 > And your webserver is misconfigured: I thinks READ.ME is a troff
 > document.

Hmm. This was fixed long time ago.

$ telnet namesys.com 80
Trying 212.16.7.65...
Connected to thebsh.namesys.com (212.16.7.65).
Escape character is '^]'.
GET /snapshots/2003.12.23/READ.ME HTTP/1.0

HTTP/1.1 200 OK
Date: Thu, 25 Dec 2003 09:20:45 GMT
Server: Apache/1.3.23 (Unix)  (Red-Hat/Linux)
Last-Modified: Tue, 23 Dec 2003 11:31:22 GMT
ETag: "e3b05-fab-3fe8278a"
Accept-Ranges: bytes
Content-Length: 4011
Connection: close
Content-Type: text/plain

 > 
 > The other changes look reasonable, although a lot of the EXPORT_SYMBOLs
 > should be probably EXPORT_SYMBOL_GPL and carry some more comments about

What are the guidelines for using EXPORT_SYMBOL vs. EXPORT_SYMBOL_GPL?

 > their purpose.
 > 
 > -Andi

Nikita.

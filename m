Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266400AbRGTBDM>; Thu, 19 Jul 2001 21:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266425AbRGTBDB>; Thu, 19 Jul 2001 21:03:01 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:1384 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S266400AbRGTBCs>; Thu, 19 Jul 2001 21:02:48 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Peter J. Braam" <braam@clusterfilesystem.com>
cc: linux-kernel@vger.kernel.org, mason@suse.com, sct@redhat.com
Subject: Re: modules/ksyms/filenames 
In-Reply-To: Your message of "Thu, 19 Jul 2001 15:54:00 CST."
             <20010719155400.E27553@lustre.clusterfilesystem.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 20 Jul 2001 11:02:00 +1000
Message-ID: <8128.995590920@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, 19 Jul 2001 15:54:00 -0600, 
"Peter J. Braam" <braam@clusterfs.com> wrote:
>I'm trying to export a symbol (journal_begin/end) from
>fs/reiserfs/journal.c. To export the symbols I added to the Makefile:
>export-objs := journal.o
>
>There is also a file fs/jbd/journal.c which exports symbols. 

It is a "feature" of the module symbol versioning that all objects
which export symbols must have globally unique basenames.  Stupid, I
know, and it will disappear in 2.5.  In the meantime, create
fs/reiserfs/reiserfs_ksyms.c and export the symbols in there.  See
kernel/ksyms.c for an example.


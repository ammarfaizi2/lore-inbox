Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266221AbUFPJCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266221AbUFPJCA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 05:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266224AbUFPJCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 05:02:00 -0400
Received: from aun.it.uu.se ([130.238.12.36]:5071 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266221AbUFPJBz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 05:01:55 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16592.3188.448186.438659@alkaid.it.uu.se>
Date: Wed, 16 Jun 2004 11:01:40 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: David Howells <dhowells@redhat.com>, Nuno Monteiro <nuno@itsari.org>,
       linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: [2.4] build error with latest BK
In-Reply-To: <40D00828.8020303@yahoo.com.au>
References: <40CFB2A1.8070104@yahoo.com.au>
	<20040615164848.GA8276@hobbes.itsari.int>
	<3473.1087374022@redhat.com>
	<40D00828.8020303@yahoo.com.au>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin writes:
 > David Howells wrote:
 > >>-		put_task_struct(tsk);
 > >>+		task_unlock(tsk);
 > > 
 > > 
 > > Ummm... that doesn't look right.
 > > 
 > > 
 > >>-	get_task_struct(tsk);
 > > 
 > > 
 > > This is necessary to stop someone deallocating the task structure, can the
 > > task structure be deallocated whilst locked?
 > > 
 > 
 > Ooh maybe it can. Should that be a read_lock of the tasklist lock then?

For 2.4 kernels, use get_task_struct() and free_task_struct() [not put]
for locking and unlocking a task.

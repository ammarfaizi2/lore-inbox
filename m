Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264965AbUGMM4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264965AbUGMM4W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 08:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264953AbUGMM4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 08:56:21 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:12725 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264965AbUGMMyv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 08:54:51 -0400
Date: Tue, 13 Jul 2004 07:54:08 -0500
From: "Jose R. Santos" <jrsantos@austin.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: "Jose R. Santos" <jrsantos@austin.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, slpratt@us.ibm.com
Subject: Re: [PATCH] Making i/dhash_entries cmdline work as it use to.
Message-ID: <20040713125408.GA9149@rx8.austin.ibm.com>
References: <20040713025643.GA7498@austin.ibm.com> <20040712175605.GA1735@rx8.austin.ibm.com> <20040713023721.GA7461@austin.ibm.com> <4348.1089722020@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <4348.1089722020@redhat.com> (from dhowells@redhat.com on Tue, Jul 13, 2004 at 07:33:40 -0500)
X-Mailer: Balsa 2.0.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/13/04 07:33:40, David Howells wrote:
> That's an enormous limit. Consider the fact that you will have a multiplicity
> of such hash tables, each potentially eating 1/16th of your total memory
> (remember, the bootmem allocator's only real limit is how big a chunk of
> memory it can allocate in one go).
> 
> Do you have numbers to show that committing an eighth of your memory (8GB if
> you have 64GB - two hash tables at 4GB apiece) to hash tables is almost
> certainly not worth it.

I do not use all that memory but this is just the absolute limit that you can
allocate.  The point is not to limit it to ORDER 14 because thats the most 
gains seen on one 64GB setup.  The idea is to give people some room to play
when they use the cmdline if for some reason they need to go that hi.

-JRS

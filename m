Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbVDRLyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbVDRLyi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 07:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbVDRLyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 07:54:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:479 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262046AbVDRLy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 07:54:28 -0400
Date: Mon, 18 Apr 2005 07:54:06 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Igor Shmukler <igor.shmukler@gmail.com>
cc: Daniel Souza <thehazard@gmail.com>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: intercepting syscalls
In-Reply-To: <6533c1c905041512594bb7abb4@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0504180752220.3232@chimarrao.boston.redhat.com>
References: <6533c1c905041511041b846967@mail.gmail.com> 
 <1113588694.6694.75.camel@laptopd505.fenrus.org>  <6533c1c905041512411ec2a8db@mail.gmail.com>
  <e1e1d5f40504151251617def40@mail.gmail.com> <6533c1c905041512594bb7abb4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2005, Igor Shmukler wrote:

> Thank you very much. I will check this out.
> A thanks to everyone else who contributed. I would still love to know
> why this is a bad idea.

Because there is no safe way in which you could have multiple
of these modules loaded simultaneously - say one security
module and AFS.  There is an SMP race during the installing
of the hooks, and the modules can still wreak havoc if they
get unloaded in the wrong order...

There just isn't a good way to hook into the syscall table.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

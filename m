Return-Path: <linux-kernel-owner+w=401wt.eu-S1753149AbWLQWph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149AbWLQWph (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 17:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753150AbWLQWph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 17:45:37 -0500
Received: from ozlabs.org ([203.10.76.45]:35855 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753149AbWLQWpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 17:45:36 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17797.51337.364669.628160@cargo.ozlabs.ibm.com>
Date: Mon, 18 Dec 2006 09:45:29 +1100
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alexandre Oliva <aoliva@redhat.com>, Ricardo Galli <gallir@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules
In-Reply-To: <Pine.LNX.4.64.0612170927110.3479@woody.osdl.org>
References: <200612161927.13860.gallir@gmail.com>
	<Pine.LNX.4.64.0612161253390.3479@woody.osdl.org>
	<orwt4qaara.fsf@redhat.com>
	<Pine.LNX.4.64.0612170927110.3479@woody.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> Why do people think that using "ln" is _any_ different from using 
> "mkisofs". Both create one file that contains multiple pieces. What's the 
> difference - really?

The difference - really - at least for static linking - is that "ln"
makes modifications to each piece to make them work together, and in
the case of a library, makes a selection of the parts of the library
as needed by the rest of the program.  What ends up in the executable
is not just a set of verbatim copies of the input files packed
together, but rather a single program where the various parts have
been modified so as to fit together and create a whole.  Thus it seems
quite reasonable to me to say that a statically linked binary is a
derived work of all of the object files and libraries that were linked
together to form it.  IANAL, of course.

Dynamic linking is different, of course, if only because the final
runnable program is never distributed, but only formed in memory
during execution.  Also, the shared libraries are not modified and
incorporated during linking.

Paul.

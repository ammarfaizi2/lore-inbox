Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbTIQJHd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 05:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbTIQJHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 05:07:33 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:47495 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262694AbTIQJHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 05:07:32 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <20030917085523.B19276@bitwizard.nl>
References: <20030917085523.B19276@bitwizard.nl>
Message-Id: <1063789628.5720.153.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 17 Sep 2003 11:07:09 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: HFS plus filenames.
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-17 at 08:55, Rogier Wolff wrote:
> Hi,
> 
> We used the new hfsplus driver lately. However it showed lots 
> of files which had a "/" in the filename. Yes in the fileNAME. 
> 
> ls would find a file called "a/b" and then stat it, but no directory
> "a" would then be found....
> 
> I tried modifying the unicode->ascii strcpy function, which I saw
> being called in the "readdir" code. That somehow didn't work,
> although I think it should have. (Not that it would have /worked/, but
> it should at least have shown "a_b" instead of "a/b") But it didn't. 
> I didn't have the time to figure it out, but one of these days
> we should mangle those names in a predictable way to make filesystems
> like this usable under Linux... Right?

I haven't looked at the code to see if it does any such mangling,
but what could be done is like OS X, that is convert back and forth
between ":" and "/" which are the path separators of respectively
MacOS and Linux.

Ben.
 


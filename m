Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbTDTP7X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 11:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263621AbTDTP7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 11:59:23 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:31236 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263620AbTDTP7W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 11:59:22 -0400
Date: Sun, 20 Apr 2003 18:13:06 +0200
To: Andrei Ivanov <andrei.ivanov@ines.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops in 2.5.68-mm1
Message-ID: <20030420161306.GA16656@hh.idb.hist.no>
References: <Pine.LNX.4.50L0.0304201843300.1931-200000@webdev.ines.ro> <Pine.LNX.4.50L0.0304201850130.1931-100000@webdev.ines.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50L0.0304201850130.1931-100000@webdev.ines.ro>
User-Agent: Mutt/1.5.3i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 20, 2003 at 06:58:33PM +0300, Andrei Ivanov wrote:
[...]
> -r--------    1 root     root        48281 Apr 11 21:05 Cats & Dogs (RO).txt
> -r--------    1 root     root     730341376 Apr 11 21:04 Cats And Dogs.avi
> 
> I typed less Cats<tab>, and then &<tab>, and here it was stuck, and the 
> kernel oopsed. If I type less Cats<tab>, and then \&<tab>, it works, but 
> without the \ in front of the &, the shell gets stuck in D state.

Typing 
<any command> &<TAB>
gives the shell and the fs some work to do.  The "&" ends one
command and starts a new one (similiar to ";") so typing
nothing more after "&" and pressing <TAB> makes the shell search the entire
path and consider all the commands available.
(Press tab some more times and see the list, 2078 possibilities
in my case. :-)  This sort of thing can easily
take some time (in D state) if your PATH includes network drives.

Helge Hafting

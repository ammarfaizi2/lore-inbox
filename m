Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267707AbUHEOHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267707AbUHEOHI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 10:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267724AbUHEOHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 10:07:07 -0400
Received: from [193.112.238.6] ([193.112.238.6]:58846 "EHLO caveman.xisl.com")
	by vger.kernel.org with ESMTP id S267707AbUHEOE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 10:04:29 -0400
From: John M Collins <jmc@xisl.com>
Organization: Xi Software Ltd
To: linux-kernel@vger.kernel.org
Subject: Program-invoking Symbolic Links?
Date: Thu, 5 Aug 2004 15:04:26 +0100
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408051504.26203.jmc@xisl.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Please CC any reply to jmc AT xisl.com as I'm not subbed - thanks).

I wondered if anyone had ever thought of implementing an alternative form of 
symbolic link which was in fact an invocation of a program?

Such a symbolic link would "do all the necessary" to fork off a new process 
running the specified program with input or output from or to a pipe 
depending on whether the link was opened for writing or reading respectively. 
RW access would probably have to be banned and the link would usually be 
read-only or write-only.

What I originally wanted was symbolic links (with "=>" as a possible 
notation).

latest_version.tar => "tar cf - /latest/and/greatest"
latest_version.tgz => "gzip -c latest_version"

and the like, which I could link on a website so I didn't have to run around 
updating tar files/zip files/gzipped tar files etc each time I fix a bug in 
some package.

Such a scheme would let you implement things like hit counts on web sites "for 
free" without you having to rush out and run a CGI program as at present.

Obviously, a whole lot of semantics and options for signal handling $PATH name 
search etc would have to be built into the kernel (or possibly handled like 
ld-nnn.so), but the idea would seem to me to close one arguable "lack of 
orthogonality" between files and pipes.

You could argue that /proc is halfway there - I'd just like a user-specific 
version.

-- 
John Collins Xi Software Ltd www.xisl.com

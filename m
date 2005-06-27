Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbVF0DLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbVF0DLA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 23:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVF0DLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 23:11:00 -0400
Received: from smtpout.mac.com ([17.250.248.86]:11979 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261776AbVF0DKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 23:10:31 -0400
In-Reply-To: <42BF667C.50606@slaphack.com>
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu> <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu> <42BF08CF.2020703@slaphack.com> <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu> <42BF2DC4.8030901@slaphack.com> <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu> <42BF667C.50606@slaphack.com>
Mime-Version: 1.0 (Apple Message framework v730)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5284F665-873C-45B7-8DDB-5F475F2CE399@mac.com>
Cc: Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: reiser4 plugins
Date: Sun, 26 Jun 2005 23:10:04 -0400
To: David Masover <ninja@slaphack.com>
X-Mailer: Apple Mail (2.730)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 26, 2005, at 22:37:48, David Masover wrote:
> $ make -C linux-2.6.12.zip/.../contents

I've yet to see how such automatic unzipping does not inherently  
introduce
system insecurity into _existing_ applications by changing POSIX and  
UNIX
semantics.

When I do this in my suid perl script:

open my $fh, '<', $ARGV[0];

I do _not_ mean this:
system '/bin/zip', 'x', $path1, $path2;

Neither do I want the kernel to unzip it, because that just  
introduces the
kernel to a whole series of normally application-level vulnerabilities.
I've seen situations where a specially doctored tarball can expand to a
result file over 1000x the size of the original.  Likewise, there  
have been
cases where crafted tarballs have taken advantage of buffer overflows.

Can you illustrate for me with precise, clear, and unambiguous arguments
how this can avoid all possible pitfalls, especially in cases where it's
likely to break existing working privileged apps?  Such extended  
operations,
including the automatic encryption/decryption and most other non- 
standard
filesystem features (Basically the whole '...' directory), should  
probably
be left out of any patch submitted for inclusion until they can be  
_proven_
(or at least thoroughly checked) not to have undesirable results.

Cheers,
Kyle Moffett

--
Somone asked me why I work on this free (http://www.fsf.org/philosophy/)
software stuff and not get a real job. Charles Shultz had the best  
answer:

"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't.  
That's why
I draw cartoons. It's my life."
-- Charles Shultz


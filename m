Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312391AbSC3Ebs>; Fri, 29 Mar 2002 23:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312392AbSC3Ebh>; Fri, 29 Mar 2002 23:31:37 -0500
Received: from pizda.ninka.net ([216.101.162.242]:24769 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S312391AbSC3EbW>;
	Fri, 29 Mar 2002 23:31:22 -0500
Date: Fri, 29 Mar 2002 20:25:53 -0800 (PST)
Message-Id: <20020329.202553.54452899.davem@redhat.com>
To: akpm@zip.com.au
Cc: kaos@ocs.com.au, jerj@coplanar.net, linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] which kernel debugger is "best"?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3CA53DE5.668AC7AB@zip.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@zip.com.au>
   Date: Fri, 29 Mar 2002 20:24:05 -0800
   
   I *have* had problems with -fno-inline.  I'd very much like
   to be able to turn that on, but the presence of `extern inline'
   functions causes a link failure with `-fno-inline'.

Feel free to submit the patch that converts the remaining extern
inline into static inline.  That is the correct solution.

GCC has every right not to inline and expect the function name to be
referencable externally if you say extern inline, so this is another
reason to fix the remaining extern inline instances.



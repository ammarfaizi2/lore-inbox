Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315234AbSD2XG0>; Mon, 29 Apr 2002 19:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315235AbSD2XGZ>; Mon, 29 Apr 2002 19:06:25 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:3591 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S315234AbSD2XGZ>;
	Mon, 29 Apr 2002 19:06:25 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: The tainted message 
In-Reply-To: Your message of "Mon, 29 Apr 2002 21:21:07 +0200."
             <20020429192107.GA26369@louise.pinerecords.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 30 Apr 2002 09:06:14 +1000
Message-ID: <26170.1020121574@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Apr 2002 21:21:07 +0200, 
tomas szepe <kala@pinerecords.com> wrote:
>Now, would anyone attempt to sum up all the points made here and come up
>w/ something like a "final-draft" proposal?

What next, gcc warnings that include sections of the C99 standard or
chunks of the info entry?  There are reasons that documentation is
separate from error and warning messages.

Summary:

  Nobody can agree on the warning text.  Anything less than the full
  kernel FAQ entry is incomplete.

  Vendors who ship binary modules and support their users should use
  different text, pointing to the vendor's support policy instead of
  bothering linux-kernel.

Solution:

  modutils 2.4.16 says

  Warning: loading <module> will taint the kernel.  Reason <reason>
    See <TAINT_URL> for information on tainted modules
  Module loaded, with warnings

  Printing 'Module loaded, with warnings' makes it clear that the
  module has been loaded.  TAINT_URL defaults to lkml FAQ.  Vendors can
  ship modutils with a TAINT_URL that points to their support policy.


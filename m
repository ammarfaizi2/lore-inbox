Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTLLW1b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 17:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262291AbTLLW1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 17:27:30 -0500
Received: from palrel13.hp.com ([156.153.255.238]:44493 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262283AbTLLW1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 17:27:21 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16346.16576.987077.529284@napali.hpl.hp.com>
Date: Fri, 12 Dec 2003 14:27:12 -0800
To: Pavel Machek <pavel@ucw.cz>
Cc: Jes Sorensen <jes@wildopensource.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, David Mosberger <davidm@hpl.hp.com>,
       jbarnes@sgi.com, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] quite down SMP boot messages
In-Reply-To: <20031212221609.GC314@elf.ucw.cz>
References: <yq0fzfr32ib.fsf@wildopensource.com>
	<20031212221609.GC314@elf.ucw.cz>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 12 Dec 2003 23:16:10 +0100, Pavel Machek <pavel@ucw.cz> said:

  >> I'd like to propose this patch for 2.6.0 or 2.6.1 to quite down some
  >> of the excessive boot messages printed for each CPU. The patch simply
  >> introduces a boot time variable 'smpverbose' which users can set if
  >> they experience problems and want to see the full set of messages.

  >> Once you hit > 2 CPUs the amount of noise printed per CPU starts
  >> becoming a pain, at 64 CPUs it's turning into a royal pain ....

  Pavel> You might want to be more creative.. With something like < for each
  Pavel> cpu going up and > for each cpu booted, you might be able to preserve
  Pavel> all the info yet make it _way_ shorter.

Sounds promising to me.  I also dislike the verbosity, but getting rid
of the messages completely makes me nervous, too, because sometimes
things do fail and then it's invaluable to have some idea of how far
the boot got (even if the person booting the machines has no clue what
the funny symbols on his screen actually mean).

	--david

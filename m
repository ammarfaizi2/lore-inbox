Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318138AbSGWRhP>; Tue, 23 Jul 2002 13:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318153AbSGWRhP>; Tue, 23 Jul 2002 13:37:15 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:12774 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S318138AbSGWRhO>;
	Tue, 23 Jul 2002 13:37:14 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15677.37942.751459.494661@napali.hpl.hp.com>
Date: Tue, 23 Jul 2002 10:36:54 -0700
To: Hugh Dickins <hugh@veritas.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Love <rml@tech9.net>,
       David Mosberger <davidm@hpl.hp.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VM accounting 3/3 noreserve
In-Reply-To: <Pine.LNX.4.21.0207231828180.10982-100000@localhost.localdomain>
References: <Pine.LNX.4.21.0207231823470.10982-100000@localhost.localdomain>
	<Pine.LNX.4.21.0207231828180.10982-100000@localhost.localdomain>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 23 Jul 2002 18:29:22 +0100 (BST), Hugh Dickins <hugh@veritas.com> said:

  Hugh> MAP_NORESERVE handling remains odd: doesn't have its own
  Hugh> VM_flag, so mprotect a private readonly MAP_NORESERVE mapping
  Hugh> to writable and the reservation is then made/checked (see
  Hugh> vmacct2 patch).  I don't mind adding VM_NORESERVE to fix that
  Hugh> later, if MAP_NORESERVE users think it necessary: David?

Well, if we support MAP_NORESERVE, we ought to do it consistently and
correctly (note: my original report was triggered by a third party
getting confused because MAP_NORESERVE didn't work as expected).

	--david

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268245AbTAMT3J>; Mon, 13 Jan 2003 14:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268243AbTAMT3J>; Mon, 13 Jan 2003 14:29:09 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:32981 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S267847AbTAMT3H>;
	Mon, 13 Jan 2003 14:29:07 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15907.5503.334066.50256@napali.hpl.hp.com>
Date: Mon, 13 Jan 2003 11:37:35 -0800
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       <ebiederm@xmission.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Consolidate vmlinux.lds.S files
In-Reply-To: <Pine.LNX.4.44.0301131309240.24477-100000@chaos.physics.uiowa.edu>
References: <20030113180450.GA1870@mars.ravnborg.org>
	<Pine.LNX.4.44.0301131309240.24477-100000@chaos.physics.uiowa.edu>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Kai> I would suggest an approach like the following, of course
  Kai> showing only a first simple step. A series of steps like this
  Kai> should allow for a serious reduction in size of
  Kai> arch/*/vmlinux.lds.S already, while being obviously correct and
  Kai> allowing archs to do their own special thing if necessary (in
  Kai> particular, IA64 seems to differ from all the other archs).

The only real difference for the ia64 vmlinux.lds.S is that it
generates correct physical addressess, so that the boot loader doesn't
have to know anything about the virtual layout of the kernel.
Something that might be useful for other arches as well...

	--david

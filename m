Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290713AbSBLBxj>; Mon, 11 Feb 2002 20:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290715AbSBLBxa>; Mon, 11 Feb 2002 20:53:30 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:2018 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S290713AbSBLBxP>;
	Mon, 11 Feb 2002 20:53:15 -0500
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15464.30088.754007.311391@napali.hpl.hp.com>
Date: Mon, 11 Feb 2002 17:53:12 -0800
To: "David S. Miller" <davem@redhat.com>
Cc: anton@samba.org, linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: thread_info implementation
In-Reply-To: <20020211.174102.28786938.davem@redhat.com>
In-Reply-To: <15464.28196.894340.327685@napali.hpl.hp.com>
	<20020211.173236.08323394.davem@redhat.com>
	<15464.29104.798819.399971@napali.hpl.hp.com>
	<20020211.174102.28786938.davem@redhat.com>
X-Mailer: VM 7.00 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 11 Feb 2002 17:41:02 -0800 (PST), "David S. Miller" <davem@redhat.com> said:

  David>    From: David Mosberger <davidm@hpl.hp.com> Date: Mon, 11
  David> Feb 2002 17:36:48 -0800

  David>    Umh, perhaps because it adds one level of indirection to
  David> every access of "current"??

  DaveM> Ummm, which is totally cached and therefore costs nothing?

Loads are certainly not free on many CPU models.  This is made worse
by the fact that C alias analysis has to be so pessimistic, especially
given that the kernel is compiled with -fno-strict-aliasing.

	--david

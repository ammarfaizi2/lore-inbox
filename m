Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290708AbSBLBhG>; Mon, 11 Feb 2002 20:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290701AbSBLBg6>; Mon, 11 Feb 2002 20:36:58 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:3802 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S290708AbSBLBgv>;
	Mon, 11 Feb 2002 20:36:51 -0500
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15464.29104.798819.399971@napali.hpl.hp.com>
Date: Mon, 11 Feb 2002 17:36:48 -0800
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, anton@samba.org, linux-kernel@vger.kernel.org,
        zippel@linux-m68k.org
Subject: Re: thread_info implementation
In-Reply-To: <20020211.173236.08323394.davem@redhat.com>
In-Reply-To: <200202120101.g1C11OJZ010115@napali.hpl.hp.com>
	<20020211.170709.118972278.davem@redhat.com>
	<15464.28196.894340.327685@napali.hpl.hp.com>
	<20020211.173236.08323394.davem@redhat.com>
X-Mailer: VM 7.00 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 11 Feb 2002 17:32:36 -0800 (PST), "David S. Miller" <davem@redhat.com> said:

  David>    From: David Mosberger <davidm@hpl.hp.com> Date: Mon, 11
  David> Feb 2002 17:21:40 -0800
   
  David>    The task pointer lives in the thread pointer register
  David> (r13), so it's trivial to address off of it.

  DaveM> So why don't you put the, oh my gosh, "THREAD INFO POINTER"
  DaveM> into the thread pointer register instead?  That is what I did
  DaveM> and everything transforms naturally, you will need to make
  DaveM> zero modifications to assembly code besides the offset macro
  DaveM> names and that you can even script :-)

Umh, perhaps because it adds one level of indirection to every access
of "current"??

	--david

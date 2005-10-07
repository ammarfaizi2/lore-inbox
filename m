Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbVJGGY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbVJGGY0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 02:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbVJGGY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 02:24:26 -0400
Received: from web35507.mail.mud.yahoo.com ([66.163.179.131]:57178 "HELO
	web35507.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751380AbVJGGYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 02:24:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=KltFuqe82Mcr3xDzlrFn6WIZgzyqcmNoOo8fY0jO9NJJc16Imn6MEUGdu6KehSQZHq1iqECWMoMSUL2nL8KrLjYr3U/FDCtEexPXJR8aNIUgmV8DxgYRB1fg6G1pX9O35mQRzMSmYDtVR5IBnd6cVVlkbX3cq8fgljyaxbZY79g=  ;
Message-ID: <20051007062425.56683.qmail@web35507.mail.mud.yahoo.com>
Date: Thu, 6 Oct 2005 23:24:25 -0700 (PDT)
From: Dan C Marinescu <dan_c_marinescu@yahoo.com>
Subject: quick (software versus hardware raid) question (cpu)
To: linux-kernel@vger.kernel.org
In-Reply-To: <20051003112931.GA5209@opteron.random>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi there,

i have a mission critical system with an unsuported
raid controller (4 sata channels, sil 3114). so, i set
up a software raid... now, the problem is at pick
hours, when nics hardware interrupts compete with the
software raid kernel thingie... i know you avoid
spawning threads but regarless the scheduller's
preeptivenes, the two kernel tasks are scheduller-wise
competing and this is killing my server (slowing it
down, cpu is at 100% user and 40-60% kernel). another
issue is that not being able to "see" the "bios"
partition (controller is totally unsuported) i cannot
boot (unless i go like raid 1 on /boot). so what about
performance? what about scalability? if case of 1
array (hardware raid) versus n distinct sata
connectors, you big o notation goes like O(n) instead
of O(1), no matter how smart the scheduller _is_
implemented, for the simple reason that hardware
interrupts are hardware interrupts... preemptive or
not, you have to serve them sooner or later and it's
one thing to sever 1 instead of n... another issue is
reliability. if you use software raid, and the kernel
goes down (for unrelated reasons) your parity
calculations and the raid cache go down as well, huh?
and the other way around... the raid goes down, taking
the sata driver with him... that takes the whole
system down, huh? well, maybe i am too pesimistic but
still, the scalability concern remains! nics are huge
scheduller enamies... they have to do so much with
cpu, and transfers to system memory, in order to
actually server thier purpose (protocols) it seams to
me that there isn't much left for user-land and
software raid... (especially when many nics and many
satas are involved...)

in short, could you recommend me a peformant (sata
connectors) raid controller, which is fully supported?
please don't go like "make gconfig" cause i've been
there... thanks!

regards,
  daniel


		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com

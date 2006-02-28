Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWB1Pa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWB1Pa6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 10:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWB1Pa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 10:30:58 -0500
Received: from smtp102.rog.mail.re2.yahoo.com ([206.190.36.80]:13479 "HELO
	smtp102.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932218AbWB1Pa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 10:30:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=SN5lM9Z5ik+kaLgz9BSlQTQrIAZZdqsZY3xarXtdtJeAaAKo6yXfz2aeF5ZOyDKQxrhtnNiQY826WAt05NCOPQ1UVGW/jZPUmzZ8TwJwuVCKrXzWpQQNZDIUyhFYeDXA+uEmDCQ8ARPk7VJ0npdRzHmkWMffZmGZNDT8pCmpJH0=  ;
Subject: Re: [2.6 patch] make UNIX a bool
From: "James C. Georgas" <jgeorgas@rogers.com>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20060228145217.GM19232@lug-owl.de>
References: <20060225160150.GX3674@stusta.de>
	 <1141078686.28136.20.camel@Rainsong.home>
	 <20060228145217.GM19232@lug-owl.de>
Content-Type: text/plain
Date: Tue, 28 Feb 2006 10:30:51 -0500
Message-Id: <1141140654.11504.25.camel@Tachyon.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a philosophical note, I like being able to unload a module and
replace it at runtime, without having to reboot. I might want to play
around with the code in a module, for educational purposes, and being
able to reload an altered module makes a huge difference in how quickly
I can test my changes.

Also, I suspect that if the modular option were removed then eventually
the code would evolve to a state where it would be impossible to
reinstate the option (i.e. the driver would become tightly coupled to
other kernel code). There have been drivers in the past that would not
build as modules, because they made the assumption that their
dependencies were built into the kernel.

A good example is the old 2.4 kernel IDE stuff, where the IDE disk
driver would barf on compilation if the IDE base driver was built as a
module instead of compiled into the kernel.

I guess it just gives me the creeps to think that we're setting up
conditions that would allow tight coupling of drivers to arise once
again.

Of course, I'm not an expert or anything. What /are/ the disadvantages
to having a modular driver, as opposed to having it built in to the
kernel?
-- 
James C. Georgas <jgeorgas@rogers.com>


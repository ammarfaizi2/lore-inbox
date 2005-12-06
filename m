Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030241AbVLFVTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbVLFVTH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 16:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbVLFVTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 16:19:06 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:43717 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1030254AbVLFVTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 16:19:02 -0500
Date: Tue, 6 Dec 2005 19:18:45 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, ehabkost@mandriva.com
Subject: Re: [PATCH 00/10] usb-serial: Switches from spin lock to atomic_t.
Message-Id: <20051206191845.6f4827b3.lcapitulino@mandriva.com.br>
In-Reply-To: <20051206130207.7658636e.zaitcev@redhat.com>
References: <20051206095610.29def5e7.lcapitulino@mandriva.com.br>
	<20051206194041.GA22890@suse.de>
	<20051206181449.11947f4f.lcapitulino@mandriva.com.br>
	<20051206130207.7658636e.zaitcev@redhat.com>
Organization: Mandriva
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi Pete,

On Tue, 6 Dec 2005 13:02:07 -0800
Pete Zaitcev <zaitcev@redhat.com> wrote:

| On Tue, 6 Dec 2005 18:14:49 -0200, Luiz Fernando Capitulino <lcapitulino@mandriva.com.br> wrote:
| 
| >  The spinlock makes the code less clear, error prone, and we already a
| > semaphore in the struct usb_serial_port.
| > 
| >  The spinlocks _seems_ useless to me.
| 
| Dude, semaphores are not compatible with interrupts. Surely you
| understand that?

 Sure thing man, take a look at this thread:

http://marc.theaimsgroup.com/?l=linux-kernel&m=113216151918308&w=2

 My comment 'we already have a semaphore in struct usb_serial_port'
was about what we've discussed in that thread, where question like
'why should we have yet another lock here?' have been made.

 And *not* 'let's use the semaphore instead'.

 If _speed_ does not make difference, the spinlock seems useless,
because we could use atomic_t instead.

-- 
Luiz Fernando N. Capitulino

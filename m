Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbVGZPIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbVGZPIB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 11:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVGZO6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 10:58:54 -0400
Received: from web25802.mail.ukl.yahoo.com ([217.12.10.187]:65133 "HELO
	web25802.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261849AbVGZO6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 10:58:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=aY5IPoF8nV/VOgJoNAk0CExEL3T/5W6lEZWOycY9IiZdH6H5kToDhtpxG6+rEoKaLfSeA1Do5PiVbYcmVoxtbuobqDGzSOxxJ2Nazd0xBflatfDahOAwRa9C0noK2ZQKR1u0+Suqll4NpZDlVaKy7Fii8EdSGLpumNQe8vORMDk=  ;
Message-ID: <20050726145830.5412.qmail@web25802.mail.ukl.yahoo.com>
Date: Tue, 26 Jul 2005 16:58:30 +0200 (CEST)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: [INPUT] simple question on driver initialisation.
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050726130329.GA3215@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Vojtech Pavlik <vojtech@suse.cz> a écrit :
> > 
> > I can't find "pinpad/input0" in sysfs, does that mean I need to add sysfs
> > suppport in my driver, and it's not done in input module when I register 
> > my input driver ?
> 
> I'm sorry, I thought it's already in mainline, but that bit is still
> missing from the sysfs support in input. It'll get there soon.
> 

cool.

> > > "pinpad/input0" doesn't sound right. What port is your pinpad connected
> > > to?
> > 
> > Actually I'm working on an embedded system which owns a pinpad controller.
> > This controller is accessed by using io mem and it talks to the pinpad
> through
> > a dedicated bus. So I accessed it through io space.
> 
> In that case, you'll likely want something like io0200/input0, where
> 0x200 would be the io address of the device. On the other hand, if it's
> really embedded and there can't be two pinpads in the system, it's not a
> problem to use basically any string there, since it only needs to be
> system-unique.
> 

It will be the case: only one embedded pinpad in the system. So something
like "kbdport/input0" should be ok...

thanks Vojtech for your time.

         Francis


	

	
		
___________________________________________________________________________ 
Appel audio GRATUIT partout dans le monde avec le nouveau Yahoo! Messenger 
Téléchargez cette version sur http://fr.messenger.yahoo.com

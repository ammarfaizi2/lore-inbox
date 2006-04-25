Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751623AbWDYQwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbWDYQwg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 12:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751622AbWDYQwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 12:52:36 -0400
Received: from web26109.mail.ukl.yahoo.com ([217.12.10.233]:24212 "HELO
	web26109.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751623AbWDYQwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 12:52:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=XZb4JTepZWvBKyqe3AIWndQ44fvKa1amEBcP1Oy9MAq7ZGVSJKBsPNF9Zjrf2w72xJ2lZQcknQ+Mw1Q3V+s971fOdGVqXAgklOZEfW6EB4FUXfCinqjH+GSZ6HMuNQOzIS5GftGWlb/6+rH9hF/ik4xhWJfASP7QjJhVgTKcens=  ;
Message-ID: <20060425161139.87285.qmail@web26109.mail.ukl.yahoo.com>
Date: Tue, 25 Apr 2006 18:11:39 +0200 (CEST)
From: Axelle Apvrille <axelle_apvrille@yahoo.fr>
Subject: Re: [ANNOUNCE] Release Digsig 1.5: kernel module for run-timeauthentication of binaries
To: Nix <nix@esperi.org.uk>, Arjan van de Ven <arjan@infradead.org>,
       drepper@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       disec-devel@lists.sourceforge.net
In-Reply-To: <87slo2nn0b.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Just my few cents on signed binaries and DigSig. It's
kind of a very partial reply to several parts of
various emails (Arjan, Ulrich, Nix ...), sorry for
that ;-)

1- "does this also prevent people writing their own
elf loader in a bit of perl and just mmap the code"

I'm not sure to exactly understand what you mean:

- if you mean writing an application able to read &
'interpret' an ELF executable: again, I think DigSig
will prevent this, because when you mmap the code,
this calls (at kernel level) do_mmap which triggers an
LSM hook called file_mmap. And we implement checks in
that hook...

- if you mean modifying the ELF loader so that do_mmap
/ file_mmap aren't called, well you'll need to hack
the kernel, won't you ?

- finally, note you also have choice not to sign this
elf loader of yours. If it isn't signed, it won't ever
run ;-)

2- "You will never get 100% protection from a
mechanism like signed binaries"

Sure. I entirely agree though, if we're honest, *no*
system is ever a 100 % protection ;-)
I think our paper (http://disec.sourceforge.net/ or
http://www.usenix.org/events/lisa04/tech/apvrille.html)
is clear about what we mean to protect and what we do
not, and IMHO, 
in security, we cannot expect more of any system.

3- "I've found signed binaries principally useful on
stripped-down firewalls and firewall UML instances"

Indeed. I foresee use of DigSig for hosts that are not
meant to change 'too' often (for example, not
a developer or a user desktop - although I do
personnally have DigSig on mine ;-)) ). Stripped-down
servers or firewalls are good example (and they do
indeed represent a big niche). BTW, I also
foresee use of DigSig in small embedded systems, and
actually, in that area, I heard of Umbrella,
an open source project using DigSig (I don't know the
status).


Hope this helps !
Best regards,

Axelle.
DigSig - http://disec.sourceforge.net


	
	
		
___________________________________________________________________________ 
Nouveau : téléphonez moins cher avec Yahoo! Messenger. Appelez le monde entier à partir de 0,012 €/minute ! 
Téléchargez sur http://fr.messenger.yahoo.com

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWDYQ4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWDYQ4r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 12:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbWDYQ4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 12:56:47 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:22977 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932261AbWDYQ4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 12:56:46 -0400
Subject: Re: [ANNOUNCE] Release Digsig 1.5: kernel module for
	run-timeauthentication of binaries
From: Arjan van de Ven <arjan@infradead.org>
To: Axelle Apvrille <axelle_apvrille@yahoo.fr>
Cc: Nix <nix@esperi.org.uk>, drepper@gmail.com, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org,
       disec-devel@lists.sourceforge.net
In-Reply-To: <20060425161139.87285.qmail@web26109.mail.ukl.yahoo.com>
References: <20060425161139.87285.qmail@web26109.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Tue, 25 Apr 2006 18:56:40 +0200
Message-Id: <1145984201.3114.34.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-25 at 18:11 +0200, Axelle Apvrille wrote:
> Hi all,
> 
> Just my few cents on signed binaries and DigSig. It's
> kind of a very partial reply to several parts of
> various emails (Arjan, Ulrich, Nix ...), sorry for
> that ;-)
> 
> 1- "does this also prevent people writing their own
> elf loader in a bit of perl and just mmap the code"
> 
> I'm not sure to exactly understand what you mean:
> 
> - if you mean writing an application able to read &
> 'interpret' an ELF executable: again, I think DigSig
> will prevent this, because when you mmap the code,
> this calls (at kernel level) do_mmap which triggers an
> LSM hook called file_mmap. And we implement checks in
> that hook...

this is not correct, you don't need mmap you can do a read just fine as
well.


> - finally, note you also have choice not to sign this
> elf loader of yours. If it isn't signed, it won't ever
> run ;-)

so you didn't sign perl ? or bash ?




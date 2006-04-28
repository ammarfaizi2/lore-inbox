Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751764AbWD1Rx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbWD1Rx6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 13:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWD1Rx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 13:53:58 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:61374 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751107AbWD1Rx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 13:53:57 -0400
Subject: Re: [ANNOUNCE] Release Digsig 1.5: kernel module for
	run-timeauthentication of binaries
From: Arjan van de Ven <arjan@infradead.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Ulrich Drepper <drepper@gmail.com>,
       Axelle Apvrille <axelle_apvrille@yahoo.fr>, Nix <nix@esperi.org.uk>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       disec-devel@lists.sourceforge.net
In-Reply-To: <20060428162904.GB31473@sergelap.austin.ibm.com>
References: <87slo2nn0b.fsf@hades.wkstn.nix>
	 <20060425161139.87285.qmail@web26109.mail.ukl.yahoo.com>
	 <a36005b50604280833k5a811384r5f3a6f92dd707256@mail.gmail.com>
	 <20060428160914.GA31473@sergelap.austin.ibm.com>
	 <1146240670.3126.20.camel@laptopd505.fenrus.org>
	 <20060428162904.GB31473@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Fri, 28 Apr 2006 19:53:51 +0200
Message-Id: <1146246831.3126.26.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-28 at 11:29 -0500, Serge E. Hallyn wrote:
> Quoting Arjan van de Ven (arjan@infradead.org):
> > 
> > > A one time effort to write it *and sign it*.
> > you don't sign nor need to sign perl or bash scripts. Why would a loader
> > be written in ELF itself? There's absolutely no reason for that.
> 
> Yup, that's an unfortunate shortcoming.  We'd been wanting to re-post to
> lkml for a long time to get ideas to fix that.
> 
> I had an extension to digsig earlier which enabled signing shellscripts
> using xattrs (just because it was a trivial task), but that's clearly
> insufficient as it would catch "./myscript.pl" but not "perl
> myscript.pl".


there is a worse one:

perl < somefile

or

wget -O - <url> | perl




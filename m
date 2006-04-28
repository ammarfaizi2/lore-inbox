Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751785AbWD1SQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbWD1SQT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 14:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbWD1SQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 14:16:19 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12950 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751785AbWD1SQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 14:16:18 -0400
Date: Fri, 28 Apr 2006 19:16:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Ulrich Drepper <drepper@gmail.com>,
       Axelle Apvrille <axelle_apvrille@yahoo.fr>, Nix <nix@esperi.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org,
       disec-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] Release Digsig 1.5: kernel module for run-timeauthentication of binaries
Message-ID: <20060428181612.GA19898@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Serge E. Hallyn" <serue@us.ibm.com>,
	Ulrich Drepper <drepper@gmail.com>,
	Axelle Apvrille <axelle_apvrille@yahoo.fr>, Nix <nix@esperi.org.uk>,
	Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	disec-devel@lists.sourceforge.net
References: <87slo2nn0b.fsf@hades.wkstn.nix> <20060425161139.87285.qmail@web26109.mail.ukl.yahoo.com> <a36005b50604280833k5a811384r5f3a6f92dd707256@mail.gmail.com> <20060428160914.GA31473@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060428160914.GA31473@sergelap.austin.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2006 at 11:09:14AM -0500, Serge E. Hallyn wrote:
> BS - you can stack another LSM to prevent that.
> 
> Or, stack it with SELinux.  I've tested that combination before with no
> problems.

The real question here is why use lsm at all?  lsm sounds like the wrong
set of hooks for something like this.  If you look at the hooks they are
clearly for access control handling, which this isn't at all.  I bet
your code would be a lot simpler if you just hooked into the right places
directly.  and made it controllable by selinux or $lsm.

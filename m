Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132942AbRDEP4l>; Thu, 5 Apr 2001 11:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132943AbRDEP4V>; Thu, 5 Apr 2001 11:56:21 -0400
Received: from natmail2.webmailer.de ([192.67.198.65]:46064 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S132942AbRDEP4L>; Thu, 5 Apr 2001 11:56:11 -0400
Date: Wed, 4 Apr 2001 18:27:34 +0200
From: "Manfred H. Winter" <mahowi@gmx.net>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.3] PPP errors
Message-ID: <20010404182734.A10985@marvin.mahowi.de>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010404021554.A1596@marvin.mahowi.de> <Pine.LNX.4.21.0104040213220.803-100000@sartre.linuxbr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.21.0104040213220.803-100000@sartre.linuxbr.com>; from sartre@linuxbr.com on Wed, Apr 04, 2001 at 02:13:49 -0300
X-Operating-System: Linux 2.4.3 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Apr 2001, Jean Paul Sartre wrote:

> On Wed, 4 Apr 2001, Manfred H. Winter wrote:
> 
> > Apr  4 02:05:21 marvin pppd[1227]: Couldn't set tty to PPP discipline: Invalid a
> > rgument
> > Apr  4 02:05:21 marvin pppd[1227]: Exit.
> 
> 	Did you load the 'ppp_async.o' module?
> 

Sorry, I forget to look for that, but:

I have the following line in /etc/modules/conf:

alias char-major-108 ppp_async
alias tty-ldisc-3 ppp
alias ppp0 ppp_generic
alias ppp1 ppp_generic
alias ppp ppp_generic
alias ppp-compress-18 ppp_mppe
alias ppp-compress-21 bsd_comp
alias ppp-compress-24 ppp_deflate
alias ppp-compress-26 ppp_deflate

So it should be autoloaded. I've added now "probe tty-ldisc-3 ppp_async
ppp" and hope it helps.

So, if ppp_async gets not autoloaded, why? And why does'nt this happen
not allways but only sometimes?

Bye,

Manfred
-- 
 /"\                        | PGP-Key available at Public Key Servers
 \ /  ASCII ribbon campaign | or at "http://www.mahowi.de/"
  X   against HTML mail     | RSA: 0xC05BC0F5 * DSS: 0x4613B5CA
 / \  and postings          | GPG: 0x88BC3576 * ICQ: 61597169

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbTFGA2n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 20:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbTFGA2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 20:28:43 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:4868 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262423AbTFGA2h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 20:28:37 -0400
Date: Sat, 7 Jun 2003 02:42:08 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: __user annotations
Message-ID: <20030607004208.GA4506@mars.ravnborg.org>
Mail-Followup-To: Paul Mackerras <paulus@samba.org>,
	Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
References: <7369DBDA-983E-11D7-8338-000A95A0560C@us.ibm.com> <Pine.LNX.4.44.0306061016250.20324-100000@home.transmeta.com> <16097.12932.161268.783738@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16097.12932.161268.783738@argo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 07, 2003 at 10:32:04AM +1000, Paul Mackerras wrote:
> Linus Torvalds writes:
> 
> > You can get check from
> > 
> > 	bk://kernel.bkbits.net/torvalds/sparse
> 
> Is that up to date?  I cloned that repository and said "make" and got
> heaps of compile errors.

Cloned it today - compiled without a single warning.
(RH8.0, gcc 3.2)

>  First there were a heap of warnings like
> this:
> 
> symbol.h:73: warning: declaration does not declare anything
My version looks like this:
        struct preprocessor_sym {
                struct token *expansion;
                struct token *arglist;
        };  <= line 73

        struct ctype_sym {

Looks like something wrong at your side...

	Sam

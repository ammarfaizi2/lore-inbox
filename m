Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266488AbUBQTcg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 14:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266494AbUBQTcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 14:32:36 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:35808 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266488AbUBQTcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 14:32:22 -0500
Date: Tue, 17 Feb 2004 11:31:30 -0800 (PST)
From: Sridhar Samudrala <sri@us.ibm.com>
X-X-Sender: sridhar@localhost.localdomain
To: "David S. Miller" <davem@redhat.com>
cc: matthias.andree@gmx.de, lksctp-developers@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com.br
Subject: Re: [Lksctp-developers] Re: [PATCH] net/sctp/Config.in make oldconfig
 compatibility (bash)
In-Reply-To: <20040217110541.6d71ef18.davem@redhat.com>
Message-ID: <Pine.LNX.4.58.0402171115030.5136@localhost.localdomain>
References: <20040217122347.GA15213@merlin.emma.line.org>
 <Pine.LNX.4.58.0402171035440.32361@localhost.localdomain>
 <20040217110541.6d71ef18.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Feb 2004, David S. Miller wrote:

> On Tue, 17 Feb 2004 10:48:55 -0800 (PST)
> Sridhar Samudrala <sri@us.ibm.com> wrote:
>
> > I thought SCTP changes were backed out just because of these 'make oldconfig'
> > errors from the 2.4 tree.
>
> I believe Marcelo is just going to clone a tree right before he took in the
> SCTP stuff, in order to do the 2.4.25 release.  Then for 2.4.26-pre1 he'll
> take the SCTP changes back in and we can add the fix.
>
> > Anyway, i have submitted the attached patch that should fix this to davem.
> > 'make oldconfig' and 'make menuconfig' worked fine after applying this patch.
>
> I believe this space fix here is necessary as well as your crypto changes
> Sridhar.

If you are referring to the space before the ] brackets in the if statements,
-  if [ "$CONFIG_CRYPTO_MD5" = "n" -a "$CONFIG_CRYPTO_SHA1" = "n"]; then
+  if [ "$CONFIG_CRYPTO_MD5" = "n" -a "$CONFIG_CRYPTO_SHA1" = "n" ]; then

those lines are no longer there in the SCTP Config.in with the crypto changes
patch.

The other space introduced in Matthias patch is in the following lines.
-        choice 'SCTP: Cookie HMAC Algorithm' \
+        choice '    SCTP: Cookie HMAC Algorithm' \

I am not sure if this is needed.

Thanks
Sridhar

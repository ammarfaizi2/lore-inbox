Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbUDUVjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbUDUVjf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 17:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbUDUVjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 17:39:35 -0400
Received: from mail.enyo.de ([212.9.189.167]:15889 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S261273AbUDUVjd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 17:39:33 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: "Fabian Uebersax" <fabian.uebersax@ch.tiscali.com>,
       linux-kernel@vger.kernel.org
Subject: Re: tcp vulnerability?  haven't seen anything on it here...
References: <435F241B01CDFC44B50865371254BC3702426157@ch-flu-exchange>
	<20040421132642.60c21268.davem@redhat.com>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Wed, 21 Apr 2004 23:39:26 +0200
In-Reply-To: <20040421132642.60c21268.davem@redhat.com> (David S. Miller's
 message of "Wed, 21 Apr 2004 13:26:42 -0700")
Message-ID: <874qrdggdt.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> On Wed, 21 Apr 2004 19:27:01 +0200
> "Fabian Uebersax" <fabian.uebersax@ch.tiscali.com> wrote:
>
>> http://www.ietf.org/internet-drafts/draft-ietf-tcpm-tcpsecure-00.txt
>
> Anyone who recommends responding to a RST packet, does not
> understand TCP very well.

This was my thought as well.  Surely you don't want to deploy such a
drastic change to the TCP state engine after just so little
investigation.

In the confined environment of BGP peerings, the risks can be
controlled (RSTs are typically rate-limited on the receiving end
anyway, for example).  On the net as a whole, you have to be
compatible with all implementations ever written.  If some
implementation replied to the ACK cookie with another RST with an
suitable sequence number, there might be a few issues.

(BTW, TCP connections used for BGP typically have port numbers from a
very small set.  So there is no additional randomness from that which
offers any additional protection.)

-- 
Current mail filters: many dial-up/DSL/cable modem hosts, and the
following domains: atlas.cz, bigpond.com, postino.it, tiscali.co.uk,
tiscali.cz, tiscali.it, voila.fr.

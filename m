Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbVF1ROY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbVF1ROY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 13:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262167AbVF1RNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 13:13:13 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:11103 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262164AbVF1RIy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 13:08:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kU7HW3wQY61Wtvl2H9zqrkDS+50FEu6HBAUAhHIQtUp3lpIet9B5Eg2B3dbpJy+hhuculsunvGJTfeDDxMSXvRYP0Sgvmv0pJPtwPQkqnAjhwcayxw9h5ENlQXTl/J7LVUjkpOdGvTBEYLTiMxJ/Q0mklCw5xVuQhfkBm+0qa3M=
Message-ID: <699a19ea05062810087b79f12f@mail.gmail.com>
Date: Tue, 28 Jun 2005 22:38:17 +0530
From: k8 s <uint32@gmail.com>
Reply-To: k8 s <uint32@gmail.com>
To: Michael Becker <michbec@t-online.de>
Subject: Re: IPSec Inbound Processing Basic Doubt
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <506243806.20050627182416@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <699a19ea050623105516cd5eb8@mail.gmail.com>
	 <506243806.20050627182416@t-online.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> So far you are right with your assumptions, I hope my explanation just
> made it a bit clearer.

Yes. It was really nice organization of whole thing.


>The whole decapsulation is done in xfrm4_rcv_encap, except in case of
>nat-traversal, where udp_rcv comes into play.
>After the whole xfrm processing is done the packet is put back into the
>network stack as it would look like without being ever processed by IPSec
>(almost :-).

I have a doubt regarding nat-traversal. Let me first admit that I
don't have a perfect understanding of the NAT traversal concept. I
heard that IPSec is kept in a UDP packet and sent.  How does the tx
side processing happen (the host from which the udp encapsulated ipsec
packet originated). The last call in the stackable destination is
ip_output() as you said.
How does it go back to udp(transport) layer in this case.

S.Kartikeyan
http://www.geocities.com/kartikeyans/

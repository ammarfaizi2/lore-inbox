Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263855AbTJEUAg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 16:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263854AbTJEUAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 16:00:19 -0400
Received: from play.smurf.noris.de ([192.109.102.42]:46510 "EHLO
	play.smurf.noris.de") by vger.kernel.org with ESMTP id S263852AbTJET7H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 15:59:07 -0400
From: Matthias Urlichs <smurf@smurf.noris.de>
Organization: {M:U} IT Consulting
Subject: Re: [PATCH] expand_resource
Date: Wed, 01 Oct 2003 19:50:10 +0200
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Message-Id: <pan.2003.10.01.17.50.10.817924@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
References: <20030930210410.GD24824@parcelfarce.linux.theplanet.co.uk> <20030930222708.A10154@flint.arm.linux.org.uk> <20030930221411.GF24824@parcelfarce.linux.theplanet.co.uk> <20030930233352.C10154@flint.arm.linux.org.uk> <20031001142553.GN24824@parcelfarce.linux.theplanet.co.uk>
X-Pan-Internal-Attribution: Hi, Matthew Wilcox wrote:
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
X-Pan-Internal-Post-Server: smurf
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: recipient list not shown:;
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matthew Wilcox wrote:
> 	int new = expand_resource(res, size, align);
> 
> 	if (new < 0) {
> 		return new;
> 	} else if (new == res->start) {
> 		/* program start */
> 	} else {
> 		/* program end */
> 	}

Umm, these /*program*/ starts/ends look backwards. 

Personally, I'd check both independently. What stops expand_resource
from doing both if there's no increase possible in only one direction to
make room for <size>?

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Battle, n.:
	A method of untying with the teeth a political knot that
	will not yield to the tongue.
		-- Ambrose Bierce

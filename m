Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262751AbUCJSb5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 13:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbUCJSb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 13:31:57 -0500
Received: from cpc1-cmbg3-5-0-cust123.cmbg.cable.ntl.com ([81.96.64.123]:22400
	"EHLO cuddles.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S262751AbUCJSbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 13:31:53 -0500
From: Andrew Haley <aph@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16463.24215.666911.238474@cuddles.cambridge.redhat.com>
Date: Wed, 10 Mar 2004 18:29:43 +0000
To: Richard Henderson <rth@twiddle.net>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Thomas Schlichter <thomas.schlichter@web.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       gcc@gcc.gnu.org
Subject: Re: [PATCH] fix warning about duplicate 'const'
In-Reply-To: <20040310182227.GA6647@twiddle.net>
References: <200403090043.21043.thomas.schlichter@web.de>
	<20040308161410.49127bdf.akpm@osdl.org>
	<Pine.LNX.4.58.0403081627450.9575@ppc970.osdl.org>
	<200403090217.40867.thomas.schlichter@web.de>
	<Pine.LNX.4.58.0403081728250.9575@ppc970.osdl.org>
	<20040310054918.GB4068@twiddle.net>
	<Pine.LNX.4.58.0403100740120.1092@ppc970.osdl.org>
	<20040310182227.GA6647@twiddle.net>
X-Mailer: VM 7.14 under Emacs 21.3.50.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Henderson writes:
 > On Wed, Mar 10, 2004 at 07:43:10AM -0800, Linus Torvalds wrote:
 > > Ok, let's try just stripping the "const" out of the min/max macros, and
 > > see what complains.
 > 
 > I remember what complains.  You get actual errors from
 > 
 > 	const int x; 
 > 	int y;
 > 	min(x, y);

Can you explain *why* we have to produce a diagnostic for "const const
int" by default?

Can't we dispatch such things to "-pedantic" ?  Or treat "const const"
like "long long" used to be, a gcc extension?

Andrew.

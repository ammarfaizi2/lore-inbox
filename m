Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbUCJSXS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 13:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262751AbUCJSXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 13:23:18 -0500
Received: from are.twiddle.net ([64.81.246.98]:49536 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S262736AbUCJSWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 13:22:32 -0500
Date: Wed, 10 Mar 2004 10:22:27 -0800
From: Richard Henderson <rth@twiddle.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Thomas Schlichter <thomas.schlichter@web.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       gcc@gcc.gnu.org
Subject: Re: [PATCH] fix warning about duplicate 'const'
Message-ID: <20040310182227.GA6647@twiddle.net>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Thomas Schlichter <thomas.schlichter@web.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	gcc@gcc.gnu.org
References: <200403090043.21043.thomas.schlichter@web.de> <20040308161410.49127bdf.akpm@osdl.org> <Pine.LNX.4.58.0403081627450.9575@ppc970.osdl.org> <200403090217.40867.thomas.schlichter@web.de> <Pine.LNX.4.58.0403081728250.9575@ppc970.osdl.org> <20040310054918.GB4068@twiddle.net> <Pine.LNX.4.58.0403100740120.1092@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403100740120.1092@ppc970.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2004 at 07:43:10AM -0800, Linus Torvalds wrote:
> Ok, let's try just stripping the "const" out of the min/max macros, and
> see what complains.

I remember what complains.  You get actual errors from

	const int x; 
	int y;
	min(x, y);


r~

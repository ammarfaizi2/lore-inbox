Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264797AbTGBGsA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 02:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264786AbTGBGsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 02:48:00 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:46568 "HELO
	develer.com") by vger.kernel.org with SMTP id S264797AbTGBGr7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 02:47:59 -0400
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] Kill div64.h dupes, parenthesize do_div() macro params
Date: Wed, 2 Jul 2003 09:02:05 +0200
User-Agent: KMail/1.5.9
Cc: <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
References: <Pine.LNX.4.44.0307012206530.2047-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0307012206530.2047-100000@home.osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307020902.05522.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 July 2003 07:09, Linus Torvalds wrote:

 > > Why 64-bit divides in particular were victimised in this manner is a
 > > matter for speculation ;)
 >
 > Because gcc historically _cannot_ generate an efficient 64/32->64
 > divide. It ends up doing a full 64/64 divide thing.

 You're right here. I've been too quick in putting my faith in gcc ;-)

 Shouldn't we complain to the gcc people? The 64/32 division is a
rather common operation in many applications besides the kernel, so
you'd expect gcc to get it right without polluting every single
project with reimplementations of do_div().

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html



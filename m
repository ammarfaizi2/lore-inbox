Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270335AbTGMS7z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 14:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270337AbTGMS7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 14:59:55 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:19673 "HELO
	develer.com") by vger.kernel.org with SMTP id S270335AbTGMS7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 14:59:55 -0400
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer S.r.l.
To: Richard Henderson <rth@twiddle.net>, Matthew Wilcox <willy@debian.org>
Subject: Re: do_div vs sector_t
Date: Sun, 13 Jul 2003 21:14:35 +0200
User-Agent: KMail/1.5.9
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
References: <20030711223359.GP20424@parcelfarce.linux.theplanet.co.uk> <20030713172622.GA13824@twiddle.net>
In-Reply-To: <20030713172622.GA13824@twiddle.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307132114.35887.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 July 2003 19:26, Richard Henderson wrote:
> On Fri, Jul 11, 2003 at 11:33:59PM +0100, Matthew Wilcox wrote:
> > Better ideas?
>
>           if (likely(((n) >> 31 >> 1) == 0)) {

Do we still need to fix this? I've already posted a patch to disallow
calling do_div() with any divisor that doesn't look like an unsigned
64bit interger.

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html



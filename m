Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266680AbUHONOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266680AbUHONOh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 09:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266679AbUHONOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 09:14:37 -0400
Received: from smtp-vbr14.xs4all.nl ([194.109.24.34]:3089 "EHLO
	smtp-vbr14.xs4all.nl") by vger.kernel.org with ESMTP
	id S266680AbUHONOf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 09:14:35 -0400
From: Sebastian =?iso-8859-1?q?K=FCgler?= <sebas@vizZzion.org>
To: linux-kernel@vger.kernel.org
Subject: =?iso-8859-1?q?=0ARe=3A_=5BPATCH=5D_Compile_fixes_for_various_fb?= drivers
Date: Sun, 15 Aug 2004 10:06:48 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200408151006.48632.sebas@vizZzion.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2004 at 09:54, you wrote:
> On Sun, Aug 15, 2004 at 01:49:13AM +0200, Sebastian Kügler wrote:
> > fb_copy_cmap has changed in 2.6.8.1 but the change is not reflected in all
> > drivers, this updates the respective framebuffer drivers.

> NAK.
> 
> First of all, that compile fix isn't - try to compile these drivers and see
> if any got fixed by that.
> 
> While we are at it, if they would compile, you would have broken them.
> Question: what do you think the argument in question was controlling
> and why would "drop it silently" be a correct fix?

I thought that fb_copy_cmap would figure that out itself now, making the 
respective call in the driver less complicated, since the calls all looked 
the same which was a wrong assumption from my side.

> And finally, the reason why these drivers would fail to compile for quite
> a while has a lot in common with the reason why they call fb_copy_cmap()
> in the first place - they are trying to provide a method that doesn't exist
> anymore and calls in question are from the instances of that method.  Fixing
> that is going to remove these calls anyway.

Hm, *a little* more complicated than I expected in the first place. I should 
have had a look at how other drivers handle that, the mere fact that the 
driver I am using myself was not in the list should've made me alert.

Anyway, sorry for the noise and thanks for having a look at it.
-- 
sebas
- - - - - - - - - - -
http://vizZzion.org
======================
Honest disagreement is often a good sign of progress. - Mahatma Gandhi 
(1869-1948)


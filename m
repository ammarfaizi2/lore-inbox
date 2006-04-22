Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWDVTxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWDVTxa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWDVTxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:53:08 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:58051 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751109AbWDVTxH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:53:07 -0400
From: Hans Verkuil <hverkuil@xs4all.nl>
To: v4l-dvb-maintainer@linuxtv.org
Subject: Re: [v4l-dvb-maintainer] [PATCH] cx25840 driver in 2.6.16 -- adds CX25836 support
Date: Sat, 22 Apr 2006 15:33:50 +0200
User-Agent: KMail/1.8.91
Cc: Scott Alfter <salfter@ssai.us>, linux-kernel@vger.kernel.org
References: <44496BDB.2090503@ssai.us>
In-Reply-To: <44496BDB.2090503@ssai.us>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604221533.51250.hverkuil@xs4all.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Scott,

Thank you for your patch! Nice work. I've integrated it into the cx25840 
driver (with some tweaks).

Please check my mercurial tree at 
http://www.linuxtv.org/hg/~hverkuil/cx25836 to see if my changes did 
not break anything for you. For the most part the changes dealt with 
preventing the cx25836/7 from touching cx25840-specific registers.

Please let me know if it is OK (or not) so that I can get it merged into 
the main v4l-dvb repository. I also need a Signed-off-by line from you 
(see http://www.linuxtv.org/v4lwiki/index.php/How_to_submit_patches) 
before I can officially merge the code.

As I am also maintainer of ivtv I'm looking forward to your ivtv 
patches. Please contact me when you are seriously starting work on 
ivtv: work is in progress to merge ivtv into the kernel, and if you can 
let me know in advance what sort of changes you need, then I can warn 
you if the changes required for the kernel merge conflict with what you 
need.

And for the record, AFAIK there is no driver for the TI TLV320AIC23B.

Regards,

	Hans Verkuil

On Saturday 22 April 2006 01:33, Scott Alfter wrote:
> My company is working on a quad CX23416-based MPEG-2 compressor card.
>  The hardware guy decided to use CX25836s to capture video, instead
> of the CX25840 that most everybody else uses.  The main difference
> between the '836 and '840 is that the '840 captures both audio and
> video, while the '836 captures video only.  The video-related
> commands between the two are mostly the same, but the chip needs a
> different initialization sequence and it'd probably be a good idea to
> keep audio-related commands away from it.  It also doesn't need to
> have audio firmware loaded.
>
> This is my first attempt at a Linux kernel patch.  I've tested it
> with NTSC input at 352x480 and 720x480, and it works well.  I'm
> currently using it with a hacked version of ivtv 0.6.1.  Those
> changes will eventually need to be released here as well, but the
> hardware design is still in a bit of flux.  I also need to put
> together a driver for the audio capture chips used on the card, the
> TI TLV320AIC23B; there appears to be no driver in the kernel for that
> chip.
>
> The patch is attached; a test mailing indicated that Thunderbird
> attaches patches inline instead of encoded.  The patch is also
> available from this URL:
>
> http://alfter.us/files/linux-2.6.16-cx25836.patch
>
> Scott Alfter
> salfter@ssai.us

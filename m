Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293646AbSCUJKp>; Thu, 21 Mar 2002 04:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293668AbSCUJKg>; Thu, 21 Mar 2002 04:10:36 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:45258 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S293659AbSCUJK0>; Thu, 21 Mar 2002 04:10:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Axel Kittenberger <Axel.Kittenberger@maxxio.at>
Subject: Re: Patch, forward release() return values to the close() call
Date: Thu, 21 Mar 2002 10:10:22 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <200203210747.IAA25949@merlin.gams.co.at> <3C99997C.6030202@mandrakesoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <16nyaE-1ala7MC@fmrl01.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 March 2002 09:27, Jeff Garzik wrote:
> Whoops, my apologies.  The patch looks ok to me.
>
> I read your text closely and the patch not close enough.  As I said, it
> is indeed wrong for a device driver to fail f_op->release(), "fail"
> being defined as leaving fd state lying around, assuming that the system
> will fail the fput().
>
> But your patch merely propagates a return value, not change behavior,
> which seems sane to me.

Hi,

close() does not directly map to release().
If you want your device to return error
information reliably, you need to implement flush().

	Regards
		Oliver

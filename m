Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293552AbSCUI26>; Thu, 21 Mar 2002 03:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293589AbSCUI2j>; Thu, 21 Mar 2002 03:28:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13324 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293552AbSCUI2e>;
	Thu, 21 Mar 2002 03:28:34 -0500
Message-ID: <3C99997C.6030202@mandrakesoft.com>
Date: Thu, 21 Mar 2002 03:27:40 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Axel Kittenberger <Axel.Kittenberger@maxxio.at>
CC: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Patch, forward release() return values to the close() call
In-Reply-To: <200203210747.IAA25949@merlin.gams.co.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whoops, my apologies.  The patch looks ok to me.

I read your text closely and the patch not close enough.  As I said, it 
is indeed wrong for a device driver to fail f_op->release(), "fail" 
being defined as leaving fd state lying around, assuming that the system 
will fail the fput().

But your patch merely propagates a return value, not change behavior, 
which seems sane to me.

    Jeff





Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264083AbTEGQqb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 12:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264089AbTEGQqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 12:46:31 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:1164 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id S264083AbTEGQqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 12:46:30 -0400
Subject: Re: OSDL DBT-2 AS vs. Deadline 2.5.68-mm2
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: markw@osdl.org
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
In-Reply-To: <200305071633.h47GXWW15850@mail.osdl.org>
References: <200305071633.h47GXWW15850@mail.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052326742.24206.16.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 07 May 2003 18:59:02 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-05-07 at 18:33, markw@osdl.org wrote:
> I've collected some data from STP to see if it's useful or if there's
> anything else that would be useful to collect. I've got some tests
> queued up for the newer patches, but I wanted to put out what I had so
> far.
> 
> 
> METRICS OVER LAST 20 MINUTES:
> --------------- -------- ----- ---- -------- -----------------------------------
> Kernel          Elevator NOTPM CPU% Blocks/s URL                                
> --------------- -------- ----- ---- -------- -----------------------------------
> 2.5.68-mm2      as        1155 94.3   8940.2 http://khack.osdl.org/stp/271356/  
> 2.5.68-mm2      deadline  1255 94.9   9598.7 http://khack.osdl.org/stp/271359/  
> 
> FUNCTIONS SORTED BY TICKS:
> -- ------------------------- ------- ------------------------- -------
>  # as 2.5.68-mm2             ticks   deadline 2.5.68-mm2       ticks  
> -- ------------------------- ------- ------------------------- -------
>  1 default_idle              6103428 default_idle              5359025
>  2 bounce_copy_vec             86272 bounce_copy_vec             97696
>  3 schedule                    63819 schedule                    70114
>  4 __make_request              30397 __blk_queue_bounce          31167
>  5 __blk_queue_bounce          26962 scsi_request_fn             26623
>  6 scsi_request_fn             24845 __make_request              25012

You are using scsi, what tcq depth are you using? AS doesn't like >4 or
something like that.

-- 
/Martin

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264056AbTEGQcT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 12:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264060AbTEGQcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 12:32:19 -0400
Received: from holomorphy.com ([66.224.33.161]:43152 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264056AbTEGQcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 12:32:18 -0400
Date: Wed, 7 May 2003 09:44:45 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: markw@osdl.org
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: OSDL DBT-2 AS vs. Deadline 2.5.68-mm2
Message-ID: <20030507164445.GH8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	markw@osdl.org, akpm@digeo.com, linux-kernel@vger.kernel.org
References: <200305071633.h47GXWW15850@mail.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305071633.h47GXWW15850@mail.osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 09:33:29AM -0700, markw@osdl.org wrote:
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
>  7 do_softirq                  21122 do_softirq                  24623
>  8 scsi_end_request            14080 system_call                 13056
>  9 system_call                 12059 try_to_wake_up              12503
> 10 try_to_wake_up              11240 dio_bio_end_io              11511

You're already in deeper trouble than elevators can get you out of as
your driver is using bounce buffers. What hardware/driver are you using?


-- wli

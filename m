Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262380AbSJKJtF>; Fri, 11 Oct 2002 05:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262383AbSJKJtF>; Fri, 11 Oct 2002 05:49:05 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:46979 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262380AbSJKJtE>;
	Fri, 11 Oct 2002 05:49:04 -0400
Date: Fri, 11 Oct 2002 11:54:40 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Richard Henderson <rth@redhat.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] fix alpha atkbd oops
Message-ID: <20021011115440.B986@ucw.cz>
References: <20021011003434.GA1705@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021011003434.GA1705@redhat.com>; from rth@redhat.com on Thu, Oct 10, 2002 at 05:34:34PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2002 at 05:34:34PM -0700, Richard Henderson wrote:
> When called from 
> 
>         if (atkbd_reset)
>                 if (atkbd_command(atkbd, NULL, ATKBD_CMD_RESET_BAT))
> 
> in atkbd_probe, we'll crash trying to write back the results
> into the null pointer.
> 
> The interface to atkbd_command seems more sensible to allow
> a null pointer to indicate that the caller doesn't care about
> the received data than to supply a dummy pointer here.

Thanks, applied.

-- 
Vojtech Pavlik
SuSE Labs

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264801AbUELIk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264801AbUELIk5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 04:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264927AbUELIk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 04:40:57 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:2432 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264801AbUELIk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 04:40:56 -0400
Date: Wed, 12 May 2004 10:40:56 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: Why pass pt_regs throughout the input system?
Message-ID: <20040512084056.GB301@ucw.cz>
References: <200405112304.50413.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405112304.50413.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 11:04:50PM -0500, Dmitry Torokhov wrote:

> I have a question - why do we have to pass pt_regs structure throughout
> entire input system? As far as I can tell it is a snapshot of all registers
> that is done at the keyboard interrupt time and it is not used for anything
> but for displaying this data when requested by SysRq.
> 
> Would it be wrong to save it by the hardware driver at interrupt time into a
> structure accessible by keyboard.c? I do not think it matters if the data
> shown by SysRq comes from interrupt other than one that serves keyboard...
> 
> Although it is somewhat a domain violation I do not think it is worse than
> fattening interface to pass information that is not needed by most of its
> users.  

Ask David S. Miller for details - I think the problem was with
simultaneous invocation of multiple pt_regs printouts.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

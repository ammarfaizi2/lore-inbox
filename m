Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263868AbUFFRso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263868AbUFFRso (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 13:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263898AbUFFRso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 13:48:44 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:23680 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S263868AbUFFRsH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 13:48:07 -0400
Date: Sun, 6 Jun 2004 19:48:39 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC/RFT] Metter mixing of relative & absolute devices by mousedev
Message-ID: <20040606174839.GB6561@ucw.cz>
References: <200405060144.52477.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405060144.52477.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 01:44:52AM -0500, Dmitry Torokhov wrote:
> Hi,
> 
> Currently mousedev re-interprets every event for every client (reader) that
> has either /dev/input/mouseX or /dev/input/mice opened. For absolute events
> mousedev converts them into relative motion data using device's size, screen
> size and previous absolute position. For /dev/input/mice that gets events
> all devices this poses a small problem as true relative events do not adjust
> previous position - so if you were using touchscreen, then a mouse and were
> to touch the thouchscreen again the cursor would jump before getting to your
> finger. 
> 
> Please consider the following patch - it processes every event only once and
> converts it into relative motion. The mousedev clients are fed with relative
> motion data only this eliminating "jumping cursor" problem. 

I see I didn't comment on this one yet: Yes, it makes a lot of sense.
Can you prepare a pull for me, or do I have it already?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

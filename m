Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263972AbUFFStC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263972AbUFFStC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 14:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263984AbUFFStC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 14:49:02 -0400
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:35439 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263972AbUFFSs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 14:48:59 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [RFC/RFT] Metter mixing of relative & absolute devices by mousedev
Date: Sun, 6 Jun 2004 13:48:57 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200405060144.52477.dtor_core@ameritech.net> <20040606174839.GB6561@ucw.cz>
In-Reply-To: <20040606174839.GB6561@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406061348.57160.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 June 2004 12:48 pm, Vojtech Pavlik wrote:
> On Thu, May 06, 2004 at 01:44:52AM -0500, Dmitry Torokhov wrote:
> > Hi,
> > 
> > Currently mousedev re-interprets every event for every client (reader) that
> > has either /dev/input/mouseX or /dev/input/mice opened. For absolute events
> > mousedev converts them into relative motion data using device's size, screen
> > size and previous absolute position. For /dev/input/mice that gets events
> > all devices this poses a small problem as true relative events do not adjust
> > previous position - so if you were using touchscreen, then a mouse and were
> > to touch the thouchscreen again the cursor would jump before getting to your
> > finger. 
> > 
> > Please consider the following patch - it processes every event only once and
> > converts it into relative motion. The mousedev clients are fed with relative
> > motion data only this eliminating "jumping cursor" problem. 
> 
> I see I didn't comment on this one yet: Yes, it makes a lot of sense.
> Can you prepare a pull for me, or do I have it already?
> 

You should have pulled it last time (before today).
-- 
Dmitry

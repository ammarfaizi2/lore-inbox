Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbVJPSfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbVJPSfy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 14:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbVJPSfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 14:35:54 -0400
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:57454 "HELO
	smtp106.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751351AbVJPSfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 14:35:53 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: force feedback envelope incomplete
Date: Sun, 16 Oct 2005 13:35:47 -0500
User-Agent: KMail/1.8.2
Cc: emard@softhome.net, Vojtech Pavlik <vojtech@suse.cz>
References: <20051015213953.GA27117@tink>
In-Reply-To: <20051015213953.GA27117@tink>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510161335.48458.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 October 2005 16:39, emard@softhome.net wrote:
> HI
> 
> Force feedback envelope struct in input.h 
> for periodic events is incomplete.
> 
> struct ff_envelope {
>         __u16 attack_length;    /* Duration of attack (ms) */
>         __u16 attack_level;     /* Level at beginning of attack */
>         __u16 fade_length;      /* Duration of fade (ms) */
>         __u16 fade_level;       /* Level at end of fade */
> };
> 
> The envelope consists of:
> 1. Attack level (Level at beginning of attack)
> 2. Attack time
> 3. Sustain level (Level at end of attack and beginning of fade)
> 4. Sustain time
> 5. Fade level (Level at the end of fade)
> 6. Fade time
> 
> If I want to implement proper envelope I propose something like this:
> 
> struct ff_envelope {
>         __u16 attack_length;    /* Duration of attack (ms) */
>         __u16 attack_level;     /* Level at beginning of attack */
>         __u16 sustain_length;   /* Duration of sustain (ms) */
>         __u16 sustain_level;    /* Sustain Level at end of attack and beginning of fade */
>         __u16 fade_length;      /* Duration of fade (ms) */
>         __u16 fade_level;       /* Level at end of fade */
> };

You might want to talk to Vojtech about this (CC-ed).

-- 
Dmitry

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318141AbSHLPsA>; Mon, 12 Aug 2002 11:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318142AbSHLPsA>; Mon, 12 Aug 2002 11:48:00 -0400
Received: from [62.40.73.125] ([62.40.73.125]:31701 "HELO Router")
	by vger.kernel.org with SMTP id <S318141AbSHLPr7>;
	Mon, 12 Aug 2002 11:47:59 -0400
Date: Mon, 12 Aug 2002 17:51:30 +0200
From: Jan Hudec <bulb@ucw.cz>
To: daniel sheltraw <l5gibson@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel to user-space communication
Message-ID: <20020812155130.GE14305@vagabond>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>,
	daniel sheltraw <l5gibson@hotmail.com>,
	linux-kernel@vger.kernel.org
References: <F137zkftciAlUNLFAYp000015b2@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F137zkftciAlUNLFAYp000015b2@hotmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2002 at 10:40:27AM -0500, daniel sheltraw wrote:
> Is there a way to comminicate to a user-space program that an
> interrupt has occurred in a kernel module?

You can send a signal or you can create a device for a process to wait
on in poll or blocking read. Signals have quite high overhead because of
the need to save state, so device will be faster (it's faster even if
the process shoul clone a thread to handle it).

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

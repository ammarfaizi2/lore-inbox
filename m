Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754780AbWKMOkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754780AbWKMOkn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 09:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754772AbWKMOkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 09:40:43 -0500
Received: from rtr.ca ([64.26.128.89]:54026 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1754780AbWKMOkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 09:40:42 -0500
Message-ID: <455883E8.20309@rtr.ca>
Date: Mon, 13 Nov 2006 09:40:40 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Shawn Starr <shawn.starr@rogers.com>
Cc: Alessandro Suardi <alessandro.suardi@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: ieee80211 & ipw2200 (ipw2100) issues
References: <200611121213.20582.shawn.starr@rogers.com> <5a4c581d0611121408y5dee562bmc44dcffaf2040747@mail.gmail.com>
In-Reply-To: <5a4c581d0611121408y5dee562bmc44dcffaf2040747@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seem to be many implementations of WPA, including:

   tkip+tkip
   tkip+ccmp
   ccmp+ccmp
   ccmp+tkip

Perhaps only some modes are working, and some are not?
The "wpa_cli" utility will show which combo is in use
(the "status" subcommand), and will also show what is happening
if you run it while wpa_supplicant is trying to connect.

My own ipw2200 here, on 2.6.18, seems to work with all of the
WPA/WPA2 combinations that my two APs have tried, including
three of the above four scenarios.

But I have updated to  v0.5.5 of the wpa_supplicant daemon for this,
and maybe that's the problem here -- daemon too old/buggy?

Cheers

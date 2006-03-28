Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWC1Q3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWC1Q3c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 11:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWC1Q3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 11:29:32 -0500
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:4100 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S932114AbWC1Q3b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 11:29:31 -0500
Date: Tue, 28 Mar 2006 18:29:33 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Frank Gevaerts <frank@gevaerts.be>
Cc: Robert Love <rlove@rlove.org>, linux-kernel@vger.kernel.org
Subject: Re: patch : hdaps on Thinkpad R52
Message-Id: <20060328182933.4184db3f.khali@linux-fr.org>
In-Reply-To: <20060314205758.GA9229@gevaerts.be>
References: <20060314205758.GA9229@gevaerts.be>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

> I had to add a new entry to the hdaps_whitelist table in hdaps.c to get
> my Thinkpad R52 recognized. Patch is attached
> (...)
>  	/* Note that DMI_MATCH(...,"ThinkPad T42") will match "ThinkPad T42p" */
>  	struct dmi_system_id hdaps_whitelist[] = {
> +		HDAPS_DMI_MATCH_NORMAL("ThinkPad H"),
>  		HDAPS_DMI_MATCH_INVERT("ThinkPad R50p"),
>  		HDAPS_DMI_MATCH_NORMAL("ThinkPad R50"),
>  		HDAPS_DMI_MATCH_NORMAL("ThinkPad R51"),

I have some doubt about this. The Thinkpad R52 is already supported
(with identifier string "ThinkPad R52", unsuprisingly) and "ThinkPad H"
doesn't exactly sound sane. Looks like your DMI data is corrupted or
something. Could you please provide the output of dmidecode and
vpddecode on your laptop?

Anyone else with a Thinkpad R52 can provide the same information for
comparison?

Feel free to send the outputs to me privately if you don't want to make
them public.

Thanks,
-- 
Jean Delvare

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbVAaTrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVAaTrI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 14:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVAaTpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 14:45:06 -0500
Received: from opersys.com ([64.40.108.71]:49931 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261339AbVAaTol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 14:44:41 -0500
Message-ID: <41FE89E0.9030802@opersys.com>
Date: Mon, 31 Jan 2005 14:41:20 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Tom Zanussi <zanussi@us.ibm.com>
CC: Andi Kleen <ak@muc.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@AM.SONY.COM>
Subject: Re: [PATCH] relayfs redux, part 2
References: <16890.38062.477373.644205@tut.ibm.com>	<m1d5volksx.fsf@muc.de>	<16892.26990.319480.917561@tut.ibm.com>	<20050131125758.GA23172@muc.de> <16894.23610.315929.805524@tut.ibm.com>
In-Reply-To: <16894.23610.315929.805524@tut.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tom Zanussi wrote:
> OK, makes sense to me - I'll get rid of relay_reserve and replace it
> with the simple putc write and variant.

Please don't do that. Instead, bring back the ad-hoc mode code, that's
what is was for anyway.

> You could just create and log into a separate relayfs channel, if you
> wanted to.  Not sure we need to add anything special to support that.

Postprocessing doesn't solve world famine ;) As far as LTT goes,
splitting events like this makes it impossible to read large traces.
Other clients are free to do as they wish.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
